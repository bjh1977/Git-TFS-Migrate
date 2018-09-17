# Introduction 
These scripts were used to migrate some TFVC projects to Git repos.  They make use of [Git-TFS](https://github.com/git-tfs/git-tfs) to get the code from TFVC and create a new repo.  This is then pushed to (pre-created) remote repos.  

Files used:

* Install-GitTFS.ps1 - for installation of Git-TFS (assumes chocolatey is already installed)
* TFS_to_Git_Migrate.ps1 - performs a "quick" clone of the TFVC location, creates a new local repo, pushes to new remote repo
* TFS_to_Git_Migrate_Master.ps1 - loops over an array of TFVC --> Git migrations, calling TFS_to_Git_Migrate.ps1 each time 
