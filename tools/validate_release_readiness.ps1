param(
    [string]$ProjectRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"
$failures = [System.Collections.Generic.List[string]]::new()

function Require-File([string]$RelativePath) {
    $path = Join-Path $ProjectRoot $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $failures.Add("Missing file: $RelativePath")
    }
}

function Require-Directory([string]$RelativePath) {
    $path = Join-Path $ProjectRoot $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Container)) {
        $failures.Add("Missing directory: $RelativePath")
    }
}

Require-File "project.godot"
Require-File "export_presets.cfg"
Require-File "scenes/main.tscn"
Require-File "Game Design Document.md"
Require-File "docs/DEVELOPMENT_PLAN.md"
Require-File "docs/ASSET_REGISTER.md"
Require-File "docs/VALIDATION_PROTOCOL.md"
Require-File "localization/ui.csv"
Require-File "localization/story.csv"
Require-File "localization/glossary.csv"

foreach ($level in 1..5) {
    $levelName = "level_{0:D2}.tscn" -f $level
    Require-File (Join-Path "scenes/levels" $levelName)
}

foreach ($runtimeRoot in @("assets/characters", "assets/enemies", "assets/world", "assets/audio/generated")) {
    Require-Directory $runtimeRoot
    $rootPath = Join-Path $ProjectRoot $runtimeRoot
    if (Test-Path -LiteralPath $rootPath -PathType Container) {
        $pngCount = @(Get-ChildItem -LiteralPath $rootPath -Filter "*.png" -File -Recurse).Count
        if ($pngCount -eq 0 -and $runtimeRoot -ne "assets/audio/generated") {
            $failures.Add("No runtime PNG assets found under: $runtimeRoot")
        }
    }
}

$presetText = Get-Content -LiteralPath (Join-Path $ProjectRoot "export_presets.cfg") -Raw
foreach ($requiredPreset in @('Web="Web"', 'Windows="Windows"', 'platform="Web"', 'platform="Windows Desktop"')) {
    if ($presetText -notmatch [regex]::Escape($requiredPreset)) {
        $failures.Add("Export preset marker missing: $requiredPreset")
    }
}

$projectText = Get-Content -LiteralPath (Join-Path $ProjectRoot "project.godot") -Raw
if ($projectText -notmatch 'run/main_scene="res://scenes/main\.tscn"') {
    $failures.Add("Main scene is not res://scenes/main.tscn")
}
if ($projectText -notmatch 'window/size/viewport_width=1280' -or $projectText -notmatch 'window/size/viewport_height=720') {
    $failures.Add("Reference viewport is not 1280x720")
}

if ($failures.Count -gt 0) {
    Write-Output "RELEASE READINESS: FAIL"
    $failures | ForEach-Object { Write-Output ("- " + $_) }
    exit 1
}

$runtimePngTotal = @(Get-ChildItem -LiteralPath (Join-Path $ProjectRoot "assets") -Filter "*.png" -File -Recurse).Count
Write-Output "RELEASE READINESS: PASS"
Write-Output "- English authority docs: present"
Write-Output "- Windows and Web export presets: present"
Write-Output "- Levels 1-5 and 1280x720 reference viewport: present"
Write-Output ("- Runtime PNG assets: {0}" -f $runtimePngTotal)
