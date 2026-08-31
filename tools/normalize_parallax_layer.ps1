param(
    [Parameter(Mandatory = $true)][string]$InputPath,
    [Parameter(Mandatory = $true)][string]$OutputPath,
    [ValidateSet('Opaque', 'Transparent')][string]$AlphaMode = 'Transparent',
    [ValidateRange(320, 3840)][int]$Width = 1280,
    [ValidateRange(180, 2160)][int]$Height = 720
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
New-Item -ItemType Directory -Force -Path ([System.IO.Path]::GetDirectoryName($resolvedOutput)) | Out-Null

$source = New-Object System.Drawing.Bitmap($resolvedInput)
try {
    $hasAlpha = (($source.PixelFormat -band [System.Drawing.Imaging.PixelFormat]::Alpha) -ne 0) -or
        (($source.PixelFormat -band [System.Drawing.Imaging.PixelFormat]::PAlpha) -ne 0)
    if ($AlphaMode -eq 'Transparent' -and -not $hasAlpha) {
        throw "Transparent layer source has no alpha channel: $resolvedInput"
    }

    $targetRatio = [double]$Width / [double]$Height
    $sourceRatio = [double]$source.Width / [double]$source.Height
    if ($sourceRatio -gt $targetRatio) {
        $cropHeight = $source.Height
        $cropWidth = [int][Math]::Round($cropHeight * $targetRatio)
        $cropLeft = [int][Math]::Floor(($source.Width - $cropWidth) / 2.0)
        $cropTop = 0
    } else {
        $cropWidth = $source.Width
        $cropHeight = [int][Math]::Round($cropWidth / $targetRatio)
        $cropLeft = 0
        $cropTop = [int][Math]::Floor(($source.Height - $cropHeight) / 2.0)
    }

    $pixelFormat = if ($AlphaMode -eq 'Transparent') {
        [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
    } else {
        [System.Drawing.Imaging.PixelFormat]::Format24bppRgb
    }
    $output = New-Object System.Drawing.Bitmap($Width, $Height, $pixelFormat)
    try {
        $graphics = [System.Drawing.Graphics]::FromImage($output)
        try {
            $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
            $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
            $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::None
            $graphics.DrawImage(
                $source,
                [System.Drawing.Rectangle]::new(0, 0, $Width, $Height),
                [System.Drawing.Rectangle]::new($cropLeft, $cropTop, $cropWidth, $cropHeight),
                [System.Drawing.GraphicsUnit]::Pixel
            )
        } finally {
            $graphics.Dispose()
        }
        $output.Save($resolvedOutput, [System.Drawing.Imaging.ImageFormat]::Png)
    } finally {
        $output.Dispose()
    }
} finally {
    $source.Dispose()
}

$check = New-Object System.Drawing.Bitmap($resolvedOutput)
try {
    $cornerAlpha = $check.GetPixel(0, 0).A
    if ($AlphaMode -eq 'Transparent' -and $cornerAlpha -ne 0) {
        throw "Normalized transparent layer corner alpha is $cornerAlpha instead of 0: $resolvedOutput"
    }
    Write-Output "$resolvedOutput | $($check.Width)x$($check.Height) | $($check.PixelFormat) | corner_alpha=$cornerAlpha"
} finally {
    $check.Dispose()
}
