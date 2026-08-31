param(
    [string]$ProjectRoot = (Get-Location).Path,
    [string]$BuildRoot = "",
    [switch]$SkipExport,
    [switch]$RunSoak,
    [int]$SoakSeconds = 1800
)

$ErrorActionPreference = "Stop"
if ([string]::IsNullOrWhiteSpace($BuildRoot)) {
    $BuildRoot = Join-Path (Split-Path $ProjectRoot -Parent) "build"
}

$godot = Join-Path $ProjectRoot ".codex-tools\godot-4.7\editor\Godot_v4.7-stable_win64_console.exe"
$failures = [System.Collections.Generic.List[string]]::new()

function Invoke-Step([string]$Name, [scriptblock]$Action) {
    Write-Output ("[release] {0}" -f $Name)
    try {
        & $Action
        if ($LASTEXITCODE -ne 0) {
            throw "exit code $LASTEXITCODE"
        }
    } catch {
        $failures.Add(("{0}: {1}" -f $Name, $_.Exception.Message))
    }
}

if (-not (Test-Path -LiteralPath $godot -PathType Leaf)) {
    $failures.Add("Godot executable not found: $godot")
} else {
    Invoke-Step "project structure" { & (Join-Path $ProjectRoot "tools\validate_project_structure.ps1") -ProjectRoot $ProjectRoot }
    Invoke-Step "localization" { & (Join-Path $ProjectRoot "tools\validate_localization.ps1") -ProjectRoot $ProjectRoot }
    Invoke-Step "release readiness" { & (Join-Path $ProjectRoot "tools\validate_release_readiness.ps1") -ProjectRoot $ProjectRoot }
    Invoke-Step "Godot smoke" { & $godot --headless --path $ProjectRoot --scene res://scenes/tests/smoke_test.tscn --quit-after 25 }
    if ($RunSoak) {
        Invoke-Step "scene-transition soak" { & (Join-Path $ProjectRoot "tools\run_soak_validation.ps1") -ProjectRoot $ProjectRoot -DurationSeconds $SoakSeconds }
    }

    if (-not $SkipExport) {
        Invoke-Step "Web export" { & $godot --headless --path $ProjectRoot --export-release Web }
        Invoke-Step "Windows export" { & $godot --headless --path $ProjectRoot --export-release Windows }
    }

    Invoke-Step "export artifacts" { & (Join-Path $ProjectRoot "tools\validate_export_artifacts.ps1") -ProjectRoot $ProjectRoot -BuildRoot $BuildRoot }
    $windowsExecutable = Join-Path $BuildRoot "low_altitude_warrior.exe"
    if (Test-Path -LiteralPath $windowsExecutable -PathType Leaf) {
        Invoke-Step "Windows exported launch" {
            Push-Location $BuildRoot
            try {
                & $windowsExecutable --headless --quit-after 3
                if ($LASTEXITCODE -ne 0) {
                    throw "exit code $LASTEXITCODE"
                }
            } finally {
                Pop-Location
            }
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Output "RELEASE VALIDATION: FAIL"
    $failures | ForEach-Object { Write-Output ("- " + $_) }
    exit 1
}

Write-Output "RELEASE VALIDATION: PASS"
Write-Output ("- Build root: {0}" -f $BuildRoot)
Write-Output ("- Exports executed: {0}" -f (-not $SkipExport))
