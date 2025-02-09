# Validate Cluster Configuration for Two Nodes with Selected Tests

# Define the cluster nodes
$Node1 = "sqlsrv-01.mylab.com"
$Node2 = "sqlsrv-02.mylab.com"
$ClusterNodes = @($Node1, $Node2)

# Define valid test categories or tests to include (excluding 'Validate Switch Enabled Teaming Configuration')
$SelectedTests = @(
    "Inventory",
    "Storage"
)

# Ensure the script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as an administrator." -ForegroundColor Red
    exit
}

# Run the validation tests
Write-Host "Starting selected cluster validation tests for nodes: $ClusterNodes" -ForegroundColor Cyan
try {
    $ValidationResults = Test-Cluster -Node $ClusterNodes -Include $SelectedTests -Verbose
    if ($ValidationResults.IsClusterCompatible) {
        Write-Host "Cluster validation completed successfully. The nodes are compatible for clustering." -ForegroundColor Green
    } else {
        Write-Host "Cluster validation completed, but the nodes are not fully compatible for clustering." -ForegroundColor Yellow
    }

    # Save validation report to a file
    $ReportPath = "C:\ClusterValidationReport.html"
    $ValidationResults | Out-File -FilePath $ReportPath
    Write-Host "Validation report saved to $ReportPath" -ForegroundColor Cyan
} catch {
    Write-Host "An error occurred during cluster validation: $_" -ForegroundColor Red
}