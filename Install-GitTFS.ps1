

$GitTFS = 'GitTFS'

$result = choco list -lo | Where-object { $_.ToLower().StartsWith($GitTFS.ToLower()) }
if ($null -eq $result) {
    Write-Host "$GitTFS not installed by Chocolatey. Installing.."
    choco install $GitTFS -y
}
else {
   Write-Host "$result already installed"
}
