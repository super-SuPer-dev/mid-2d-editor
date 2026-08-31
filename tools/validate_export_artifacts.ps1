param(
    [string]$ProjectRoot = (Get-Location).Path,
    [string]$BuildRoot = ""
)

$ErrorActionPreference = "Stop"
$failures = [System.Collections.Generic.List[string]]::new()

if ([string]::IsNullOrWhiteSpace($BuildRoot)) {
    $BuildRoot = Join-Path (Split-Path $ProjectRoot -Parent) "build"
}

function Require-Artifact([string]$Name, [int64]$MinimumBytes) {
    $path = Join-Path $BuildRoot $Name
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $failures.Add("Missing artifact: $Name")
        return
    }
    $length = (Get-Item -LiteralPath $path).Length
    if ($length -lt $MinimumBytes) {
        $failures.Add(("Artifact is unexpectedly small: {0} ({1} bytes, expected at least {2})" -f $Name, $length, $MinimumBytes))
    }
}

Require-Artifact "low_altitude_warrior.exe" 100000000
Require-Artifact "low_altitude_warrior.pck" 100000000
Require-Artifact "game.html" 1000
Require-Artifact "game.js" 100000
Require-Artifact "game.wasm" 1000000
Require-Artifact "game.pck" 100000000

if ($failures.Count -gt 0) {
    Write-Output "EXPORT ARTIFACTS: FAIL"
    $failures | ForEach-Object { Write-Output ("- " + $_) }
    exit 1
}

Write-Output "EXPORT ARTIFACTS: PASS"
Write-Output ("- Windows executable and PCK: {0}" -f (Join-Path $BuildRoot "low_altitude_warrior.exe"))
Write-Output ("- Web HTML/JS/WASM/PCK: {0}" -f $BuildRoot)
