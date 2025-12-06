# PowerShell script to push backend logic as KAKOOZAMICHAEL
# Run this script: .\PUSH_AS_KAKOOZAMICHAEL.ps1

Write-Host "=== Push Backend Logic as KAKOOZAMICHAEL ===" -ForegroundColor Cyan
Write-Host "Repository: DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7" -ForegroundColor White
Write-Host ""

# Check if git is initialized
if (-not (Test-Path .git)) {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
}

# Set remote if not exists
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    Write-Host "Adding remote repository..." -ForegroundColor Yellow
    git remote add origin https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7.git
    $remote = git remote get-url origin
}

Write-Host "Remote: $remote" -ForegroundColor Green
Write-Host ""

# Configure git user for KAKOOZAMICHAEL
$currentUser = git config user.name
$currentEmail = git config user.email

if ($currentUser -ne "KAKOOZAMICHAEL") {
    Write-Host "⚠️  Git user is not set to KAKOOZAMICHAEL" -ForegroundColor Yellow
    Write-Host "Current user: $currentUser" -ForegroundColor White
    Write-Host ""
    
    $configure = Read-Host "Set git user to KAKOOZAMICHAEL? (y/n)"
    if ($configure -eq 'y') {
        git config user.name "KAKOOZAMICHAEL"
        $email = Read-Host "Enter email for KAKOOZAMICHAEL account"
        git config user.email $email
        Write-Host "✅ Git user set to KAKOOZAMICHAEL" -ForegroundColor Green
    }
} else {
    Write-Host "✅ Git user: KAKOOZAMICHAEL <$currentEmail>" -ForegroundColor Green
}

Write-Host ""

# Check GitHub CLI authentication
Write-Host "Checking GitHub authentication..." -ForegroundColor Yellow
$ghStatus = gh auth status 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  GitHub CLI not authenticated" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You need to authenticate as KAKOOZAMICHAEL:" -ForegroundColor Yellow
    Write-Host "  1. Run: gh auth login" -ForegroundColor White
    Write-Host "  2. Select GitHub.com" -ForegroundColor White
    Write-Host "  3. Login as KAKOOZAMICHAEL" -ForegroundColor White
    Write-Host ""
    $auth = Read-Host "Authenticate now? (y/n)"
    if ($auth -eq 'y') {
        gh auth login
    }
} else {
    Write-Host $ghStatus
    Write-Host ""
    
    # Check if logged in as KAKOOZAMICHAEL
    $ghUser = gh api user --jq .login 2>$null
    if ($ghUser -ne "KAKOOZAMICHAEL") {
        Write-Host "⚠️  Currently logged in as: $ghUser" -ForegroundColor Yellow
        Write-Host "You need to login as KAKOOZAMICHAEL" -ForegroundColor Yellow
        Write-Host ""
        $switch = Read-Host "Switch to KAKOOZAMICHAEL account? (y/n)"
        if ($switch -eq 'y') {
            gh auth login
        }
    } else {
        Write-Host "✅ Authenticated as KAKOOZAMICHAEL" -ForegroundColor Green
    }
}

Write-Host ""

# Check backend folder
if (-not (Test-Path backend)) {
    Write-Host "❌ Backend folder not found!" -ForegroundColor Red
    exit
}

$fileCount = (Get-ChildItem -Path backend -Recurse -File).Count
Write-Host "Found $fileCount files in backend folder" -ForegroundColor Green
Write-Host ""

# Check if files are already committed
$status = git status --porcelain backend/

if ($status) {
    Write-Host "Files to be committed:" -ForegroundColor Cyan
    Write-Host $status
    Write-Host ""
    
    # Add files
    Write-Host "Adding backend files..." -ForegroundColor Yellow
    git add backend/
    
    # Commit
    Write-Host "Committing files..." -ForegroundColor Yellow
    $commitMessage = @"
Add complete backend logic for MechKonect application

Uploaded by: KAKOOZAMICHAEL
- Added data models (User, Mechanic, Booking, Payment, Review)
- Added repositories (Auth, Booking, Mechanic, Payment)
- Added services (API, Local Storage, Location, Notifications)
- Added API endpoints configuration
- Added seed data for development
- Added comprehensive README documentation
"@
    
    git commit -m $commitMessage
    
    Write-Host "✅ Files committed!" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "Files already staged/committed" -ForegroundColor Yellow
    Write-Host ""
}

# Check which branch to push to
Write-Host "Checking remote branches..." -ForegroundColor Yellow
$remoteBranches = git ls-remote --heads origin 2>$null

$branch = "main"
if ($remoteBranches -match "refs/heads/master") {
    $branch = "master"
    Write-Host "Found 'master' branch on remote" -ForegroundColor Green
} elseif ($remoteBranches -match "refs/heads/main") {
    $branch = "main"
    Write-Host "Found 'main' branch on remote" -ForegroundColor Green
} else {
    Write-Host "No remote branches found. Will create 'main' branch." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Ready to push as KAKOOZAMICHAEL to: origin/$branch" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  IMPORTANT: Make sure you're authenticated as KAKOOZAMICHAEL" -ForegroundColor Yellow
Write-Host "   If prompted for credentials:" -ForegroundColor Yellow
Write-Host "   - Username: KAKOOZAMICHAEL" -ForegroundColor White
Write-Host "   - Password: [Your Personal Access Token]" -ForegroundColor White
Write-Host ""
$confirm = Read-Host "Push to GitHub now? (y/n)"

if ($confirm -eq 'y') {
    Write-Host ""
    Write-Host "Pushing to GitHub as KAKOOZAMICHAEL..." -ForegroundColor Yellow
    Write-Host ""
    
    git push -u origin $branch
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Successfully pushed to GitHub as KAKOOZAMICHAEL!" -ForegroundColor Green
        Write-Host ""
        Write-Host "View your files at:" -ForegroundColor Cyan
        Write-Host "https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/tree/$branch/backend" -ForegroundColor White
        Write-Host ""
        Write-Host "Verify the commit shows KAKOOZAMICHAEL as the author." -ForegroundColor Yellow
    } else {
        Write-Host ""
        Write-Host "❌ Push failed!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Possible issues:" -ForegroundColor Yellow
        Write-Host "  1. Not authenticated as KAKOOZAMICHAEL" -ForegroundColor White
        Write-Host "  2. KAKOOZAMICHAEL is not a collaborator on the repository" -ForegroundColor White
        Write-Host "  3. Authentication credentials incorrect" -ForegroundColor White
        Write-Host "  4. Network connection issue" -ForegroundColor White
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "  - Run: gh auth login (to authenticate as KAKOOZAMICHAEL)" -ForegroundColor White
        Write-Host "  - Verify collaborator access at:" -ForegroundColor White
        Write-Host "    https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/settings/access" -ForegroundColor White
        Write-Host "  - Use Personal Access Token if prompted" -ForegroundColor White
        Write-Host ""
        Write-Host "Try manually: git push -u origin $branch" -ForegroundColor White
    }
} else {
    Write-Host "Push cancelled." -ForegroundColor Yellow
    Write-Host "When ready, run: git push -u origin $branch" -ForegroundColor White
}

Write-Host ""
Write-Host "=== Script Complete ===" -ForegroundColor Cyan

