param(
    [ValidateRange(8, 64)]
    [int]$Gutter = 20
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$failures = [System.Collections.Generic.List[string]]::new()
$operators = @('tonkla', 'rin', 'khem', 't800')
$cellSize = 280
$columns = 4
$rows = 5

foreach ($operator in $operators) {
    $path = Join-Path $PSScriptRoot "..\assets\characters\operators\${operator}_sprite_sheet_generated_v4.png"
    if (-not (Test-Path -LiteralPath $path)) {
        $failures.Add("Missing operator sheet: $path")
        continue
    }

    $bitmap = New-Object System.Drawing.Bitmap((Resolve-Path -LiteralPath $path).Path)
    try {
        if ($bitmap.Width -ne $cellSize * $columns -or $bitmap.Height -ne $cellSize * $rows) {
            $failures.Add("$operator has $($bitmap.Width)x$($bitmap.Height); expected 1120x1400.")
            continue
        }
        $hasAlpha = (($bitmap.PixelFormat -band [System.Drawing.Imaging.PixelFormat]::Alpha) -ne 0) -or
            (($bitmap.PixelFormat -band [System.Drawing.Imaging.PixelFormat]::PAlpha) -ne 0)
        if (-not $hasAlpha) {
            $failures.Add("$operator has no alpha channel.")
            continue
        }

        $leak = $null
        for ($y = 0; $y -lt $bitmap.Height -and $null -eq $leak; $y++) {
            for ($x = 0; $x -lt $bitmap.Width; $x++) {
                if ($bitmap.GetPixel($x, $y).A -eq 0) {
                    continue
                }
                $localX = $x % $cellSize
                $localY = $y % $cellSize
                if ($localX -lt $Gutter -or $localX -ge $cellSize - $Gutter -or
                    $localY -lt $Gutter -or $localY -ge $cellSize - $Gutter) {
                    $leak = "($x,$y)"
                    break
                }
            }
        }
        if ($null -ne $leak) {
            $failures.Add("$operator has a nontransparent pixel in a protected cell gutter at $leak.")
        } else {
            Write-Output "PASS ${operator}: 1120x1400 RGBA, ${Gutter}px gutters clear"
        }
    } finally {
        $bitmap.Dispose()
    }
}

if ($failures.Count -gt 0) {
    foreach ($failure in $failures) {
        Write-Error $failure
    }
    exit 1
}

Write-Output "Operator sprite-grid gate passed for $($operators.Count) sheets."
