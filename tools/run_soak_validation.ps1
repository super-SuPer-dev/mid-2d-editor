param(
    [string]$ProjectRoot = (Get-Location).Path,
    [int]$DurationSeconds = 1800,
    [int]$ProjectileCapHoldSeconds = 60
)

$ErrorActionPreference = "Stop"
$godot = Join-Path $ProjectRoot ".codex-tools\godot-4.7\editor\Godot_v4.7-stable_win64_console.exe"
if (-not (Test-Path -LiteralPath $godot -PathType Leaf)) {
    Write-Output ("SOAK VALIDATION: FAIL`n- Godot executable not found: {0}" -f $godot)
    exit 1
}
if ($DurationSeconds -lt 1) {
    Write-Output "SOAK VALIDATION: FAIL`n- DurationSeconds must be at least 1."
    exit 1
}
if ($ProjectileCapHoldSeconds -lt 0) {
    Write-Output "SOAK VALIDATION: FAIL`n- ProjectileCapHoldSeconds cannot be negative."
    exit 1
}

Write-Output ("[soak] running {0} seconds" -f $DurationSeconds)
Write-Output ("[soak] projectile cap hold: {0} seconds per level" -f $ProjectileCapHoldSeconds)
$startInfo = [System.Diagnostics.ProcessStartInfo]::new()
$startInfo.FileName = $godot
$startInfo.WorkingDirectory = $ProjectRoot
$startInfo.UseShellExecute = $false
$startInfo.ArgumentList.Add("--headless")
$startInfo.ArgumentList.Add("--path")
$startInfo.ArgumentList.Add($ProjectRoot)
$startInfo.ArgumentList.Add("--scene")
$startInfo.ArgumentList.Add("res://scenes/tests/soak_test.tscn")
$startInfo.ArgumentList.Add("--")
$startInfo.ArgumentList.Add("--soak-seconds=$DurationSeconds")
$startInfo.ArgumentList.Add("--projectile-cap-hold-seconds=$ProjectileCapHoldSeconds")
$process = [System.Diagnostics.Process]::new()
$process.StartInfo = $startInfo
if (-not $process.Start()) {
    Write-Output "SOAK VALIDATION: FAIL`n- Could not start Godot."
    exit 1
}
$timeoutMilliseconds = [int64]($DurationSeconds + ($ProjectileCapHoldSeconds * 5) + 60) * 1000
if (-not $process.WaitForExit($timeoutMilliseconds)) {
    $process.Kill($true)
    $process.WaitForExit()
    Write-Output ("SOAK VALIDATION: FAIL`n- Timed out after {0} seconds." -f ($DurationSeconds + ($ProjectileCapHoldSeconds * 5) + 60))
    exit 1
}
$exitCode = $process.ExitCode
if ($exitCode -ne 0) {
    Write-Output ("SOAK VALIDATION: FAIL`n- Godot exit code: {0}" -f $exitCode)
    exit $exitCode
}
Write-Output ("SOAK VALIDATION: PASS`n- Duration: {0} seconds" -f $DurationSeconds)
