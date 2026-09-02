[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$SourceRelativePath = 'art_source/generated',
    [int]$MaxTextureSize = 16384,
    [ValidateRange(1, 64)]
    [int]$AlphaSampleStride = 4,
    [ValidateRange(1, 8)]
    [int]$NormalizedAlphaSampleStride = 2,
    [double]$SoftAlphaLimitPercent = 2.0,
    [switch]$StrictSoftAlpha
)

$ErrorActionPreference = 'Stop'
$resolvedRoot = (Resolve-Path -LiteralPath $ProjectRoot).Path
$sourceRoot = Join-Path $resolvedRoot $SourceRelativePath
if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) {
    Write-Output "GENERATED ASSET VALIDATION FAILED`nMissing source directory: $SourceRelativePath"
    exit 1
}

if (-not ('GeneratedAssetImageValidator' -as [type])) {
    Add-Type -AssemblyName System.Drawing
    $drawingDirectory = [System.IO.Path]::GetDirectoryName(
        [System.Drawing.Bitmap].Assembly.Location
    )
    Add-Type -Path (Join-Path $PSScriptRoot 'generated_asset_validator.cs') -ReferencedAssemblies @(
        [System.Drawing.Bitmap].Assembly.Location,
        [System.Drawing.Color].Assembly.Location,
        (Join-Path $drawingDirectory 'System.Private.Windows.GdiPlus.dll'),
        (Join-Path $drawingDirectory 'System.Private.Windows.Core.dll')
    )
}

$files = @(Get-ChildItem -LiteralPath $sourceRoot -Recurse -File -Filter '*.png')
$failures = [System.Collections.Generic.List[string]]::new()
$softAlphaWarnings = [System.Collections.Generic.List[string]]::new()
$provenanceMissing = [System.Collections.Generic.List[string]]::new()
$normalizedGeometryFailures = [System.Collections.Generic.List[string]]::new()
$decoded = 0
$transparentFiles = 0
$semiFiles = 0
$opaqueFiles = 0
$normalizedFiles = 0
$normalizedGeometryPass = 0
$provenancePass = 0
$totalBytes = 0L

function Add-Unique {
    param(
        [System.Collections.Generic.List[string]]$List,
        [string]$Message
    )
    if (-not $List.Contains($Message)) {
        $List.Add($Message)
    }
}

foreach ($file in $files) {
    $totalBytes += $file.Length
    $relative = $file.FullName.Substring($resolvedRoot.Length + 1).Replace('\', '/')
    try {
        $isNormalized = $file.BaseName -match '(?i)_normalized_'
        $inspectStride = if ($isNormalized) { $NormalizedAlphaSampleStride } else { $AlphaSampleStride }
        $stats = [GeneratedAssetImageValidator]::Inspect($file.FullName, $inspectStride)
    }
    catch {
        Add-Unique $failures "Decode failed: $relative ($($_.Exception.Message))"
        continue
    }

    $decoded++
    if ($stats.Width -le 0 -or $stats.Height -le 0) {
        Add-Unique $failures "Zero-size image: $relative"
    }
    if ($stats.Width -gt $MaxTextureSize -or $stats.Height -gt $MaxTextureSize) {
        Add-Unique $failures "Texture exceeds ${MaxTextureSize}px: $relative ($($stats.Width)x$($stats.Height))"
    }

    $pixelCount = [double]$stats.SampledPixels
    $semiPercent = if ($pixelCount -gt 0) {
        100.0 * $stats.SemiTransparentPixels / $pixelCount
    }
    else { 0.0 }

    if ($stats.TransparentPixels -gt 0) { $transparentFiles++ }
    if ($stats.SemiTransparentPixels -gt 0) { $semiFiles++ }
    if ($stats.OpaquePixels -eq $pixelCount) { $opaqueFiles++ }

    if ($isNormalized) {
        $normalizedFiles++
        if ($stats.Width % 4 -eq 0) {
            $normalizedGeometryPass++
        }
        else {
            Add-Unique $normalizedGeometryFailures "Normalized strip width is not divisible by four: $relative ($($stats.Width)x$($stats.Height))"
        }
    }

    $isVfx = $relative -match '(?i)(vfx|projectiles|projectile|impact|beam|glow|smoke|telegraph|effect)'
    $isBackground = $relative -match '(?i)(background|parallax)'
    if (-not $isVfx -and -not $isBackground -and $semiPercent -gt $SoftAlphaLimitPercent) {
        Add-Unique $softAlphaWarnings ("Soft alpha {0:N2}% exceeds {1:N2}%: {2}" -f $semiPercent, $SoftAlphaLimitPercent, $relative)
    }

    $directory = $file.Directory
    $hasProvenance = $false
    for ($depth = 0; $depth -lt 3 -and $null -ne $directory; $depth++) {
        if (@(Get-ChildItem -LiteralPath $directory.FullName -File -Filter '*.md').Count -gt 0) {
            $hasProvenance = $true
            break
        }
        $directory = $directory.Parent
    }
    if ($hasProvenance) {
        $provenancePass++
    }
    else {
        Add-Unique $provenanceMissing "No nearby Markdown provenance record: $relative"
    }
}

if ($files.Count -eq 0) {
    Add-Unique $failures "No PNG candidates found under $SourceRelativePath"
}

if ($failures.Count -gt 0) {
    Write-Output "GENERATED ASSET VALIDATION FAILED ($($failures.Count))"
    foreach ($failure in $failures) { Write-Output " - $failure" }
    exit 1
}

Write-Output 'GENERATED ASSET VALIDATION PASS'
Write-Output ("Scanned {0} PNG candidates ({1:N0} bytes); decoded {2}/{0}. Alpha percentages use {3}x sampling ({4}x for normalized strips)." -f $files.Count, $totalBytes, $decoded, $AlphaSampleStride, $NormalizedAlphaSampleStride)
Write-Output ("Transparency: {0} with transparent pixels, {1} with semi-transparent pixels, {2} fully opaque." -f $transparentFiles, $semiFiles, $opaqueFiles)
Write-Output ("Normalized geometry: {0}/{1} strips have widths divisible by four." -f $normalizedGeometryPass, $normalizedFiles)
Write-Output ("Nearby provenance: {0}/{1} files have a Markdown record within two parent levels." -f $provenancePass, $files.Count)

if ($normalizedGeometryFailures.Count -gt 0) {
    Write-Output "Normalized geometry warnings ($($normalizedGeometryFailures.Count))"
    foreach ($warning in $normalizedGeometryFailures | Select-Object -First 12) { Write-Output " - $warning" }
}

if ($provenanceMissing.Count -gt 0) {
    Write-Output "Provenance warnings: $($provenanceMissing.Count) files lack a nearby Markdown record."
}

if ($softAlphaWarnings.Count -gt 0) {
    Write-Output "Soft-alpha warnings: $($softAlphaWarnings.Count) opaque-art candidates exceed ${SoftAlphaLimitPercent}% semi-transparent pixels."
    foreach ($warning in $softAlphaWarnings | Select-Object -First 12) { Write-Output " - $warning" }
    if ($StrictSoftAlpha) {
        exit 2
    }
}
else {
    Write-Output 'Soft-alpha gate: pass for opaque-art candidates.'
}
