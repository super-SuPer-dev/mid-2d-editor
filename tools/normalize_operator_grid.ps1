param(
    [Parameter(Mandatory = $true)][string]$InputPath,
    [Parameter(Mandatory = $true)][string]$OutputPath,
    [Parameter(Mandatory = $true)][string]$ProofPath,
    [ValidateRange(128, 512)][int]$CellSize = 280,
    [ValidateRange(8, 64)][int]$Gutter = 20,
    [ValidateRange(1, 255)][int]$AlphaThreshold = 96,
    [ValidateRange(0.5, 1.0)][float]$ContentScale = 0.9
)

$ErrorActionPreference = 'Stop'
$processorSource = Join-Path $PSScriptRoot 'operator_sheet_grid_processor.cs'
if (-not ('OperatorSheetGridProcessor' -as [type])) {
    Add-Type -AssemblyName System.Drawing
    $drawingDirectory = [System.IO.Path]::GetDirectoryName([System.Drawing.Bitmap].Assembly.Location)
    Add-Type -Path $processorSource -ReferencedAssemblies @(
        [System.Drawing.Bitmap].Assembly.Location,
        [System.Drawing.Color].Assembly.Location,
        (Join-Path $drawingDirectory 'System.Private.Windows.GdiPlus.dll'),
        (Join-Path $drawingDirectory 'System.Private.Windows.Core.dll')
    )
}

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
$resolvedProof = [System.IO.Path]::GetFullPath($ProofPath)
New-Item -ItemType Directory -Force -Path ([System.IO.Path]::GetDirectoryName($resolvedOutput)) | Out-Null
New-Item -ItemType Directory -Force -Path ([System.IO.Path]::GetDirectoryName($resolvedProof)) | Out-Null

$report = [OperatorSheetGridProcessor]::Normalize(
    $resolvedInput, $resolvedOutput, $resolvedProof,
    $CellSize, $Gutter, $AlphaThreshold, $ContentScale
)
Write-Output "$resolvedOutput | proof=$resolvedProof | $report"
