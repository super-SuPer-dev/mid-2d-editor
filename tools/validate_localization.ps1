[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$resolvedRoot = (Resolve-Path -LiteralPath $ProjectRoot).Path
$tablePaths = @(
    'localization/ui.csv',
    'localization/story.csv',
    'localization/glossary.csv'
)
$failures = [System.Collections.Generic.List[string]]::new()
$allKeys = [System.Collections.Generic.Dictionary[string, string]]::new(
    [System.StringComparer]::Ordinal
)
$strictUtf8 = [System.Text.UTF8Encoding]::new($false, $true)
$placeholderPattern = '\{[A-Za-z][A-Za-z0-9_]*\}'
$entryCount = 0

function Add-Failure {
    param([string]$Message)
    if (-not $failures.Contains($Message)) {
        $failures.Add($Message)
    }
}

function Get-Placeholders {
    param([string]$Text)
    return @(
        [regex]::Matches($Text, $placeholderPattern) |
            ForEach-Object { $_.Value } |
            Sort-Object
    )
}

foreach ($relativePath in $tablePaths) {
    $absolutePath = Join-Path $resolvedRoot $relativePath
    if (-not (Test-Path -LiteralPath $absolutePath -PathType Leaf)) {
        Add-Failure "Missing localization table: $relativePath"
        continue
    }

    try {
        [void]$strictUtf8.GetString([System.IO.File]::ReadAllBytes($absolutePath))
    }
    catch {
        Add-Failure "Localization table is not valid UTF-8: $relativePath"
        continue
    }

    $rows = @(Import-Csv -LiteralPath $absolutePath)
    if ($rows.Count -eq 0) {
        Add-Failure "Localization table has no entries: $relativePath"
        continue
    }

    $columns = @($rows[0].PSObject.Properties.Name)
    foreach ($requiredColumn in @('key', 'en', 'th')) {
        if ($requiredColumn -notin $columns) {
            Add-Failure "Localization table lacks '$requiredColumn': $relativePath"
        }
    }
    if ($failures | Where-Object { $_ -like "Localization table lacks*${relativePath}" }) {
        continue
    }

    $tableKeys = [System.Collections.Generic.HashSet[string]]::new(
        [System.StringComparer]::Ordinal
    )
    for ($rowIndex = 0; $rowIndex -lt $rows.Count; $rowIndex++) {
        $row = $rows[$rowIndex]
        $lineNumber = $rowIndex + 2
        $key = ([string]$row.key).Trim()
        $english = [string]$row.en
        $thai = [string]$row.th

        if ($key.Length -eq 0 -or $key.StartsWith('#')) {
            continue
        }
        $entryCount++

        if ($key -cnotmatch '^[A-Z][A-Z0-9_]*$') {
            Add-Failure "Invalid localization key at ${relativePath}:${lineNumber}: $key"
        }
        if (-not $tableKeys.Add($key)) {
            Add-Failure "Duplicate key in ${relativePath}: $key"
        }
        if ($allKeys.ContainsKey($key)) {
            Add-Failure "Key appears in both $($allKeys[$key]) and ${relativePath}: $key"
        }
        else {
            $allKeys[$key] = $relativePath
        }
        if ([string]::IsNullOrWhiteSpace($english)) {
            Add-Failure "Missing English text at ${relativePath}:${lineNumber}: $key"
        }
        if ([string]::IsNullOrWhiteSpace($thai)) {
            Add-Failure "Missing Thai text at ${relativePath}:${lineNumber}: $key"
        }

        $englishPlaceholders = @(Get-Placeholders $english)
        $thaiPlaceholders = @(Get-Placeholders $thai)
        if (($englishPlaceholders -join '|') -cne ($thaiPlaceholders -join '|')) {
            Add-Failure "Placeholder mismatch at ${relativePath}:${lineNumber}: $key"
        }
    }
}

$sceneRoot = Join-Path $resolvedRoot 'scenes'
if (Test-Path -LiteralPath $sceneRoot -PathType Container) {
    foreach ($sceneFile in Get-ChildItem -LiteralPath $sceneRoot -Recurse -File -Filter '*.tscn') {
        $relativePath = $sceneFile.FullName.Substring($resolvedRoot.Length + 1)
        $lineNumber = 0
        foreach ($line in [System.IO.File]::ReadLines($sceneFile.FullName)) {
            $lineNumber++
            if ($line -notmatch '^\s*text\s*=\s*"(?<value>[^"]*)"\s*$') {
                continue
            }
            $value = $Matches.value
            if ($value.Length -gt 0 -and -not $allKeys.ContainsKey($value)) {
                Add-Failure "Scene text must be empty or a localization key at ${relativePath}:${lineNumber}: $value"
            }
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Output "LOCALIZATION VALIDATION FAILED ($($failures.Count))"
    foreach ($failure in $failures) {
        Write-Output " - $failure"
    }
    exit 1
}

Write-Output 'LOCALIZATION VALIDATION PASS'
Write-Output "Checked $entryCount unique English/Thai entries across $($tablePaths.Count) tables."
