param (
    $TFSProjectPath = '$/company/Platform/Area/Dev/AzureDW',
    $GitRepoPath = 'Platform/_git/ADS.AzureDW',
    $LocalRepoRootFolder = 'c:\temp\repo_migrate\',
    $TFSUSerName = 'ben.howard@company.com',
    $TFSPassword,
    $TFSPath = 'https://company.visualstudio.com/DefaultCollection',
    $GitRootPath = 'https://company.visualstudio.com/DefaultCollection'
)

$ErrorActionPreference = 'stop'

# Refresh environment vars
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

$GitRepoURL = "$GitRootPath/$GitRepoPath"
$GitRepoLocalPath = Join-Path $LocalRepoRootFolder (Split-Path $TFSProjectPath -Leaf)

If (Test-Path $LocalRepoRootFolder) {
    Write-Host "New repo root folder '$LocalRepoRootFolder' already exists." -ForegroundColor Magenta

    If (Test-Path $GitRepoLocalPath) {
        Write-Error "New repo location '$GitRepoLocalPath' already exists."
    }
}
else {
    New-Item -ItemType Directory -Path $LocalRepoRootFolder -Force | Out-Null
}
Set-Location $LocalRepoRootFolder

Write-Host "Migrating TFVC project '$TFSProjectPath' to Git repo '$GitRepoPath" -ForegroundColor Green
Write-Host "Cloning TFVC project.." -ForegroundColor Green
git tfs quick-clone --username=$TFSUSerName --password=$TFSPassword $TFSPath $TFSProjectPath -d

Set-Location $GitRepoLocalPath

git filter-branch -f --msg-filter "sed 's/^git-tfs-id:.*$//g'" -- --all
git filter-branch -f --msg-filter "sed 's/^git-tfs-id:.*;C\([0-9]*\)$/Changeset:\1/g'" -- --all

# Push to remote
Write-Host "Pushing to Git repo '$GitRepoURL'" -ForegroundColor Green
git remote add origin $GitRepoURL
git push -u origin --all
