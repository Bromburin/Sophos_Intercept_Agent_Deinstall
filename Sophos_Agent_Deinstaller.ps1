# Define the file paths
$uninstallExePath1 = "C:\Program Files\Sophos\Sophos Endpoint Agent\SophosUninstall.exe"
$uninstallExePath2 = "C:\Program Files\Sophos\Sophos Endpoint Agent\uninstallgui.exe"

# Determine which executable to use
if (Test-Path $uninstallExePath1) {
    $uninstallExePath = $uninstallExePath1
} elseif (Test-Path $uninstallExePath2) {
    $uninstallExePath = $uninstallExePath2
} else {
    Write-Output "Neither uninstall executable was found. Exiting."
    exit 1
}

try {
    # Attempt to uninstall Sophos
    $process = Start-Process -FilePath $uninstallExePath -ArgumentList "--quiet" -Wait -PassThru

    # Get the exit code
    $exitCode = $process.ExitCode

    # Handle exit codes
    switch ($exitCode) {
        0  { Write-Output "Uninstallation completed successfully." }
        1  { Write-Output "Uninstallation completed successfully; reboot required." }
        2  { Write-Output "Uninstallation failed." }
        3  { Write-Output "Uninstallation failed; reboot required." }
        4  { Write-Output "Uninstallation unknown error." }
        5  { Write-Output "Tamper protection is active." }
        6  { Write-Output "Uninstallation requires administrator privileges." }
        7  { Write-Output "Server lockdown is active." }
        8  { Write-Output "Uninstallation pending reboot." }
        default { Write-Output "An unknown error occurred. Exit code: $exitCode" }
    }
} catch {
    "An error occurred: $_"
}
