param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [int]$FrameCount = 4,
    [int]$CellWidth = 700,
    [int]$CellHeight = 800,
    [int]$BaselineY = 740,
    [ValidateRange(1, 255)]
    [int]$AlphaThreshold = 128
)

$ErrorActionPreference = 'Stop'
$normalizerSource = Join-Path $PSScriptRoot 'SpriteStripNormalizer.cs'
if (-not ('SpriteStripNormalizer' -as [type])) {
    Add-Type -AssemblyName System.Drawing
    $drawingDirectory = [System.IO.Path]::GetDirectoryName(
        [System.Drawing.Bitmap].Assembly.Location
    )
    Add-Type -Path $normalizerSource -ReferencedAssemblies @(
        [System.Drawing.Bitmap].Assembly.Location,
        [System.Drawing.Color].Assembly.Location,
        (Join-Path $drawingDirectory 'System.Private.Windows.GdiPlus.dll'),
        (Join-Path $drawingDirectory 'System.Private.Windows.Core.dll')
    )
}

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)

$report = [SpriteStripNormalizer]::Normalize(
    $resolvedInput,
    $resolvedOutput,
    $FrameCount,
    $CellWidth,
    $CellHeight,
    $BaselineY,
    $AlphaThreshold
)

Write-Output "$resolvedOutput | $report"
