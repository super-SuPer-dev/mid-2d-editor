param(
    [string]$ProjectRoot = (Get-Location).Path,
    [string]$BuildRoot = ""
)

$ErrorActionPreference = "Stop"
if ([string]::IsNullOrWhiteSpace($BuildRoot)) {
    $BuildRoot = Join-Path (Split-Path $ProjectRoot -Parent) "build"
}
$executable = Join-Path $BuildRoot "low_altitude_warrior.exe"
if (-not (Test-Path -LiteralPath $executable -PathType Leaf)) {
    Write-Output ("EXPORTED LOCALIZATION: FAIL`n- Missing Windows executable: {0}" -f $executable)
    exit 1
}

$startInfo = [System.Diagnostics.ProcessStartInfo]::new()
$startInfo.FileName = $executable
$startInfo.WorkingDirectory = $BuildRoot
$startInfo.UseShellExecute = $false
$startInfo.RedirectStandardOutput = $true
$startInfo.RedirectStandardError = $true
$startInfo.ArgumentList.Add("--headless")
$startInfo.ArgumentList.Add("--quit-after")
$startInfo.ArgumentList.Add("3")
$process = [System.Diagnostics.Process]::new()
$process.StartInfo = $startInfo
if (-not $process.Start()) {
    Write-Output "EXPORTED LOCALIZATION: FAIL`n- Could not start Windows executable."
    exit 1
}
$stdoutTask = $process.StandardOutput.ReadToEndAsync()
$stderrTask = $process.StandardError.ReadToEndAsync()
if (-not $process.WaitForExit(15000)) {
    $process.Kill($true)
    $process.WaitForExit()
    Write-Output "EXPORTED LOCALIZATION: FAIL`n- Windows executable did not exit within 15 seconds."
    exit 1
}
$output = ($stdoutTask.Result + "`n" + $stderrTask.Result)
$patterns = @(
    "Localization table could not be opened",
    "Missing localization key",
    "Failed to load localization"
)
$matches = @($patterns | ForEach-Object {
    $pattern = $_
    $output -split "`r?`n" | Where-Object { $_ -match [regex]::Escape($pattern) }
})
if ($matches.Count -gt 0) {
    Write-Output "EXPORTED LOCALIZATION: FAIL"
    $matches | Select-Object -First 20 | ForEach-Object { Write-Output ("- " + $_.Trim()) }
    exit 1
}
if ($process.ExitCode -ne 0) {
    Write-Output ("EXPORTED LOCALIZATION: FAIL`n- Windows executable exit code: {0}" -f $process.ExitCode)
    exit $process.ExitCode
}
Write-Output "EXPORTED LOCALIZATION: PASS"
Write-Output "- Windows export loaded localization tables without missing-key errors."
