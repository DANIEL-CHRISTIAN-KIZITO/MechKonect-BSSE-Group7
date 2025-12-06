# PowerShell script to push backend logic to GitHub
# Run this script in PowerShell: .\PUSH_TO_GITHUB.ps1

Write-Host "=== MechKonect Backend Upload Script ===" -ForegroundColor Cyan
Write-Host ""

# Check if git is initialized
if (-not (Test-Path .git)) {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
}

# Check remote
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    Write-Host "Adding remote repository..." -ForegroundColor Yellow
    git remote add origin https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7.git
    $remote = git remote get-url origin
}

Write-Host "Remote repository: $remote" -ForegroundColor Green
Write-Host ""

# Check git user configuration
$userName = git config user.name
$userEmail = git config user.email

if (-not $userName -or -not $userEmail) {
    Write-Host "⚠️  Git user not configured!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please configure your git user first:" -ForegroundColor Yellow
    Write-Host "  git config user.name 'Your Name'" -ForegroundColor White
    Write-Host "  git config user.email 'your.email@example.com'" -ForegroundColor White
    Write-Host ""
    $configure = Read-Host "Would you like to configure it now? (y/n)"
    if ($configure -eq 'y') {
        $name = Read-Host "Enter your name"
        $email = Read-Host "Enter your email"
        git config user.name $name
        git config user.email $email
        Write-Host "✅ Git user configured!" -ForegroundColor Green
    }
    else {
        Write-Host "Please configure git user and run this script again." -ForegroundColor Red
        exit
    }
}
else {
    Write-Host "Git user: $userName <$userEmail>" -ForegroundColor Green
    Write-Host ""
}

# Check if backend folder exists
if (-not (Test-Path backend)) {
    Write-Host "❌ Backend folder not found!" -ForegroundColor Red
    exit
}

# Count files
$fileCount = (Get-ChildItem -Path backend -Recurse -File).Count
Write-Host "Found $fileCount files in backend folder" -ForegroundColor Green
Write-Host ""

# Add files
Write-Host "Adding backend files to git..." -ForegroundColor Yellow
git add backend/
$status = git status --porcelain backend/

if ($status) {
    Write-Host "Files to be committed:" -ForegroundColor Cyan
    Write-Host $status
    Write-Host ""
    
    # Commit
    Write-Host "Committing files..." -ForegroundColor Yellow
    git commit -m "Add complete backend logic for MechKonect application

- Added data models (User, Mechanic, Booking, Payment, Review)
- Added repositories (Auth, Booking, Mechanic, Payment)
- Added services (API, Local Storage, Location, Notifications)
- Added API endpoints configuration
- Added seed data for development
- Added comprehensive README documentation"
    
    Write-Host "✅ Files committed!" -ForegroundColor Green
    Write-Host ""
    
    # Check which branch to push to
    Write-Host "Checking remote branches..." -ForegroundColor Yellow
    $remoteBranches = git ls-remote --heads origin 2>$null
    
    $branch = "main"
    if ($remoteBranches -match "refs/heads/master") {
        $branch = "master"
    }
    elseif ($remoteBranches -match "refs/heads/main") {
        $branch = "main"
    }
    else {
        Write-Host "No remote branches found. Will create 'main' branch." -ForegroundColor Yellow
    }
    
    Write-Host ""
    Write-Host "Ready to push to: origin/$branch" -ForegroundColor Cyan
    Write-Host ""
    $confirm = Read-Host "Push to GitHub now? (y/n)"
    
    if ($confirm -eq 'y') {
        Write-Host ""
        Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
        Write-Host "Note: You may be prompted for GitHub credentials." -ForegroundColor Yellow
        Write-Host ""
        
        git push -u origin $branch
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
            Write-Host "View your files at: https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/tree/$branch/backend" -ForegroundColor Cyan
        }
        else {
            Write-Host ""
            Write-Host "❌ Push failed. Possible reasons:" -ForegroundColor Red
            Write-Host "  1. Authentication required (use GitHub CLI or personal access token)" -ForegroundColor Yellow
            Write-Host "  2. No write access to repository" -ForegroundColor Yellow
            Write-Host "  3. Network connection issue" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Try manually: git push -u origin $branch" -ForegroundColor White
        }
    }
    else {
        Write-Host "Push cancelled. Run 'git push -u origin $branch' when ready." -ForegroundColor Yellow
    }
}
else {
    Write-Host "No changes to commit. Files may already be committed." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Checking if files are pushed to remote..." -ForegroundColor Yellow
    
    $localCommit = git log -1 --oneline 2>$null
    $remoteCommit = git log origin/$branch -1 --oneline 2>$null
    
    if ($localCommit -and $localCommit -ne $remoteCommit) {
        Write-Host "Local commits not pushed. Run: git push -u origin $branch" -ForegroundColor Yellow
    }
    else {
        Write-Host "✅ Files appear to be up to date!" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "=== Script Complete ===" -ForegroundColor Cyan

