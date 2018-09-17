

$Migrations = @(
        @{
            TFSProjectPath='$/removed/path/info/Dev/AzureDataFactory'
            GitRepoPath='DataServices/_git/DataServices-ADS-AzureDataFactory'    
        },
        @{
            TFSProjectPath='$/removed/path/info/Dev/AzureDB'
            GitRepoPath='DataServices/_git/DataServices-ADS-AzureSQLDB'    
        },
        @{
            TFSProjectPath='$/removed/path/info/Dev/AzureDW'
            GitRepoPath='DataServices/_git/DataServices-ADS-AzureSQLDW'    
        },
        @{
            TFSProjectPath='$/removed/path/info/Dev/AzureKeyVault'
            GitRepoPath='DataServices/_git/DataServices-ADS-AzureKeyVault'    
        },
        @{
            TFSProjectPath='$/removed/path/info/Dev/AzureLogicApp'
            GitRepoPath='DataServices/_git/DataServices-ADS-AzureLogicApp'    
        },
        @{
            TFSProjectPath='$/removed/path/info/Dev/AzureServiceBus'
            GitRepoPath='DataServices/_git/DataServices-ADS-AzureServiceBus'    
        },
        @{
            TFSProjectPath='$/removed/path/info/Dev/PowerBI'
            GitRepoPath='DataServices/_git/DataServices-ADS-PowerBI'    
        },
        @{
            TFSProjectPath='$/removed/path/info/Dev/PowerShell'
            GitRepoPath='DataServices/_git/DataServices-ADS-Scripts'    
        }
)

$Migrations | ForEach-Object {

    Write-Host "Migrating '$($_.TFSProjectPath)' to '$($_.GitRepoPath)'" -ForegroundColor Black -BackgroundColor White
    & "$PSScriptRoot\TFS_to_Git_Migrate.ps1" -TFSProjectPath $_.TFSProjectPath -GitRepoPath $_.GitRepoPath

}