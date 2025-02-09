# Enable Failover Clustering and Multipath I/O

# Run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as an administrator." -ForegroundColor Red
    exit
}

# Install Failover Clustering
Write-Host "Installing Failover Clustering..." -ForegroundColor Cyan
Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools -Verbose

# Install Multipath I/O
Write-Host "Installing Multipath I/O..." -ForegroundColor Cyan
Install-WindowsFeature -Name Multipath-IO -IncludeManagementTools -Verbose

# Enable MPIO for all devices
Write-Host "Configuring MPIO to claim all devices..." -ForegroundColor Cyan
Enable-WindowsOptionalFeature -Online -FeatureName MultiPathIO

# Restart for MPIO changes to take effect
Write-Host "Restarting the system to apply MPIO settings..." -ForegroundColor Yellow
Restart-Computer -Force