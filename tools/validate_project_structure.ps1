[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$resolvedRoot = (Resolve-Path -LiteralPath $ProjectRoot).Path
$failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure {
    param([string]$Message)
    if (-not $failures.Contains($Message)) {
        $failures.Add($Message)
    }
}

foreach ($requiredPath in @(
    'assets',
    'art_source',
    'docs',
    'localization',
    'scenes',
    'src',
    'tools',
    'validation',
    'art_source/.gdignore',
    'tools/.gdignore',
    'validation/.gdignore'
)) {
    if (-not (Test-Path -LiteralPath (Join-Path $resolvedRoot $requiredPath))) {
        Add-Failure "Missing required project path: $requiredPath"
    }
}

$runtimeRoots = @('assets', 'scenes', 'src', 'localization')
$validName = '^[a-z0-9]+(?:_[a-z0-9]+)*(?:\.[a-z0-9]+)*$'
foreach ($runtimeRoot in $runtimeRoots) {
    $absoluteRoot = Join-Path $resolvedRoot $runtimeRoot
    if (-not (Test-Path -LiteralPath $absoluteRoot)) {
        continue
    }
    foreach ($entry in Get-ChildItem -LiteralPath $absoluteRoot -Recurse -Force) {
        if ($entry.Name -eq '.gdignore') {
            continue
        }
        if ($entry.Name -cnotmatch $validName) {
            $relative = $entry.FullName.Substring($resolvedRoot.Length + 1)
            Add-Failure "Runtime path is not lowercase snake_case: $relative"
        }
        if (-not $entry.PSIsContainer -and $entry.BaseName -match '^\d+$') {
            $relative = $entry.FullName.Substring($resolvedRoot.Length + 1)
            Add-Failure "Runtime asset has a generic numeric name: $relative"
        }
    }
}

foreach ($sourceRoot in @('art_source', 'validation')) {
    $absoluteRoot = Join-Path $resolvedRoot $sourceRoot
    if (-not (Test-Path -LiteralPath $absoluteRoot)) {
        continue
    }
    foreach ($importFile in Get-ChildItem -LiteralPath $absoluteRoot -Recurse -File -Filter '*.import') {
        $relative = $importFile.FullName.Substring($resolvedRoot.Length + 1)
        Add-Failure "Non-runtime tree contains Godot import metadata: $relative"
    }
}

$excludedDirectoryPattern = '\\(\.git|\.godot|\.codex-tools|addons)(\\|$)'
foreach ($candidate in Get-ChildItem -LiteralPath $resolvedRoot -Recurse -File -Force) {
    if ($candidate.FullName -match $excludedDirectoryPattern) {
        continue
    }
    if ($candidate.Name -match '(\.tmp$|\.bak$|\.orig$|\.rej$|~$)') {
        $relative = $candidate.FullName.Substring($resolvedRoot.Length + 1)
        Add-Failure "Recovery or merge artifact is present: $relative"
    }
}

$textExtensions = @('.gd', '.tscn', '.tres', '.cfg', '.godot')
$textFiles = [System.Collections.Generic.List[System.IO.FileInfo]]::new()
foreach ($scanPath in @('project.godot', 'assets', 'localization', 'scenes', 'src')) {
    $absolutePath = Join-Path $resolvedRoot $scanPath
    if (-not (Test-Path -LiteralPath $absolutePath)) {
        continue
    }
    $item = Get-Item -LiteralPath $absolutePath
    if ($item.PSIsContainer) {
        foreach ($file in Get-ChildItem -LiteralPath $absolutePath -Recurse -File) {
            if ($file.Extension.ToLowerInvariant() -in $textExtensions) {
                $textFiles.Add($file)
            }
        }
    }
    else {
        $textFiles.Add($item)
    }
}

$resourcePattern = 'res://[^"''\s\)\]]+'
$forbiddenPattern = '^res://(?:Assets|Scenes|Generated-Assets|art_source|tools)/'
foreach ($textFile in $textFiles) {
    $content = [System.IO.File]::ReadAllText($textFile.FullName)
    foreach ($match in [regex]::Matches($content, $resourcePattern)) {
        $resourcePath = $match.Value
        if ($resourcePath -cmatch $forbiddenPattern) {
            Add-Failure "Forbidden runtime reference in $($textFile.Name): $resourcePath"
            continue
        }
        if ($resourcePath -cmatch '^res://validation/') {
            $sourceRelative = $textFile.FullName.Substring($resolvedRoot.Length + 1)
            if ($sourceRelative -cnotmatch '^src\\tests\\') {
                Add-Failure "Validation evidence is referenced outside test code in $($textFile.Name): $resourcePath"
            }
        }
        if ($resourcePath.Contains('*')) {
            continue
        }
        $relativeTarget = $resourcePath.Substring(6).Replace('/', [IO.Path]::DirectorySeparatorChar)
        if (-not (Test-Path -LiteralPath (Join-Path $resolvedRoot $relativeTarget))) {
            Add-Failure "Missing resource target in $($textFile.Name): $resourcePath"
        }
    }
}

Push-Location $resolvedRoot
try {
    $trackedPaths = @(& git ls-files)
    if ($LASTEXITCODE -ne 0) {
        Add-Failure 'Unable to inspect the Git index.'
    }
    foreach ($trackedPath in $trackedPaths) {
        if ($trackedPath -cmatch '^(Assets|Scenes|Actors)/') {
            Add-Failure "Legacy top-level path remains tracked: $trackedPath"
        }
        if ($trackedPath -match '(\.tmp$|\.bak$|\.orig$|\.rej$|~$)') {
            Add-Failure "Recovery or merge artifact remains tracked: $trackedPath"
        }
    }
}
finally {
    Pop-Location
}

if ($failures.Count -gt 0) {
    Write-Output "PROJECT STRUCTURE VALIDATION FAILED ($($failures.Count))"
    foreach ($failure in $failures) {
        Write-Output " - $failure"
    }
    exit 1
}

Write-Output "PROJECT STRUCTURE VALIDATION PASS"
Write-Output "Checked $($textFiles.Count) runtime text files and $($runtimeRoots.Count) runtime roots."
