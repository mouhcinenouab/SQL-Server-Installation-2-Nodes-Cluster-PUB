# Define the log file
$LogFile = "C:\Temp\Temp\ssms_output.txt"

function Install-SQLServerManagementStudio {
    Write-Host "Installing SQL Server Management Studio..."
    
    # Define the path to the already downloaded installer
    $InstallerPath = "C:\Temp\SSMS-Setup-ENU.exe"
    
    # Check if the installer exists
    if (Test-Path $InstallerPath) {
        # Run the installer with silent installation arguments
        Start-Process -FilePath $InstallerPath -Args "/install /quiet" -Verb RunAs -Wait
        Write-Host "SQL Server Management Studio installation completed." | Out-File -FilePath $LogFile -Append
    } else {
        Write-Host "Error: Installer not found at $InstallerPath" | Out-File -FilePath $LogFile -Append
    }
}

# Call the function
Install-SQLServerManagementStudio