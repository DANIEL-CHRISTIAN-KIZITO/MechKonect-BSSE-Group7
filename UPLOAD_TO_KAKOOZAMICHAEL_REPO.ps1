# Upload backend logic to KAKOOZAMICHAEL/contribution-MechKonet-App
# Repository: https://github.com/KAKOOZAMICHAEL/contribution-MechKonet-App.git
# Run: .\UPLOAD_TO_KAKOOZAMICHAEL_REPO.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Upload Backend Logic to" -ForegroundColor Cyan
Write-Host "  KAKOOZAMICHAEL/contribution-MechKonet-App" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Configure Git User
Write-Host "Step 1: Configuring Git for KAKOOZAMICHAEL..." -ForegroundColor Yellow
git config user.name "KAKOOZAMICHAEL"
$email = git config user.email
if (-not $email) {
    Write-Host "Enter your GitHub email:" -ForegroundColor Yellow
    $email = Read-Host "Email"
    git config user.email $email
}
Write-Host "✅ Git user: KAKOOZAMICHAEL <$email>" -ForegroundColor Green
Write-Host ""

# Step 2: Check GitHub CLI
Write-Host "Step 2: Checking GitHub CLI..." -ForegroundColor Yellow
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue

if (-not $ghInstalled) {
    Write-Host "❌ GitHub CLI not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Install GitHub CLI from: https://cli.github.com/" -ForegroundColor Yellow
    Write-Host "After installation, run this script again." -ForegroundColor Yellow
    exit
}

Write-Host "✅ GitHub CLI installed" -ForegroundColor Green

# Check authentication
$ghStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Not authenticated with GitHub CLI" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Logging in as KAKOOZAMICHAEL..." -ForegroundColor Cyan
    Write-Host "Follow the prompts:" -ForegroundColor White
    Write-Host "  - Select: GitHub.com" -ForegroundColor White
    Write-Host "  - Select: HTTPS" -ForegroundColor White
    Write-Host "  - Select: Authenticate via browser" -ForegroundColor White
    Write-Host "  - Login as: KAKOOZAMICHAEL" -ForegroundColor White
    Write-Host ""
    gh auth login
}
else {
    $ghUser = gh api user --jq .login 2>$null
    if ($ghUser -eq "KAKOOZAMICHAEL") {
        Write-Host "✅ Authenticated as KAKOOZAMICHAEL" -ForegroundColor Green
    }
    else {
        Write-Host "⚠️  Currently logged in as: $ghUser" -ForegroundColor Yellow
        Write-Host "Switching to KAKOOZAMICHAEL..." -ForegroundColor Yellow
        gh auth login
    }
}

Write-Host ""

# Step 3: Initialize Git Repository (if needed)
Write-Host "Step 3: Setting up repository..." -ForegroundColor Yellow
if (-not (Test-Path .git)) {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
}

# Set remote to KAKOOZAMICHAEL's repository
$targetRepo = "https://github.com/KAKOOZAMICHAEL/contribution-MechKonet-App.git"
$currentRemote = git remote get-url origin 2>$null

if ($currentRemote -ne $targetRepo) {
    if ($currentRemote) {
        Write-Host "Updating remote to: $targetRepo" -ForegroundColor Yellow
        git remote set-url origin $targetRepo
    }
    else {
        Write-Host "Adding remote: $targetRepo" -ForegroundColor Yellow
        git remote add origin $targetRepo
    }
    Write-Host "✅ Remote configured" -ForegroundColor Green
}
else {
    Write-Host "✅ Remote already set correctly" -ForegroundColor Green
}

Write-Host ""

# Step 4: Check Backend Files
Write-Host "Step 4: Checking backend files..." -ForegroundColor Yellow
if (-not (Test-Path backend)) {
    Write-Host "❌ Backend folder not found!" -ForegroundColor Red
    Write-Host "Make sure you're in the project root directory." -ForegroundColor Yellow
    exit
}

$files = Get-ChildItem -Path backend -Recurse -File
$fileCount = $files.Count
Write-Host "✅ Found $fileCount files in backend folder" -ForegroundColor Green
Write-Host ""

# Step 5: Add and Commit Backend Files
Write-Host "Step 5: Preparing backend files for commit..." -ForegroundColor Yellow
$status = git status --porcelain backend/

if ($status) {
    Write-Host "Files to be committed:" -ForegroundColor Cyan
    Write-Host $status
    Write-Host ""
    
    git add backend/
    Write-Host "✅ Files added to staging" -ForegroundColor Green
    Write-Host ""
    
    $commitMessage = @"
Add complete backend logic for MechKonect application

Backend components:
- Data models (User, Mechanic, Booking, Payment, Review)
- Repositories (Auth, Booking, Mechanic, Payment)
- Services (API, Local Storage, Location, Notifications)
- API endpoints configuration
- Seed data for development
- Comprehensive README documentation

Total: $fileCount files
"@
    
    git commit -m $commitMessage
    Write-Host "✅ Files committed" -ForegroundColor Green
}
else {
    Write-Host "Files already staged/committed" -ForegroundColor Yellow
}

Write-Host ""

# Step 6: Check if repository exists on GitHub
Write-Host "Step 6: Verifying repository on GitHub..." -ForegroundColor Yellow
$repoExists = gh repo view KAKOOZAMICHAEL/contribution-MechKonet-App --json name 2>$null

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Repository not found or not accessible" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Creating repository on GitHub..." -ForegroundColor Cyan
    $create = Read-Host "Create repository 'contribution-MechKonet-App'? (y/n)"
    if ($create -eq 'y') {
        gh repo create contribution-MechKonet-App --public --source=. --remote=origin --push=false
        Write-Host "✅ Repository created" -ForegroundColor Green
    }
    else {
        Write-Host "Please create the repository manually at:" -ForegroundColor Yellow
        Write-Host "https://github.com/new" -ForegroundColor White
        Write-Host "Repository name: contribution-MechKonet-App" -ForegroundColor White
        exit
    }
}
else {
    Write-Host "✅ Repository exists on GitHub" -ForegroundColor Green
}

Write-Host ""

# Step 7: Push to GitHub using CLI
Write-Host "Step 7: Pushing to GitHub..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Repository: KAKOOZAMICHAEL/contribution-MechKonet-App" -ForegroundColor White
Write-Host "  Branch: main" -ForegroundColor White
Write-Host "  Files: $fileCount backend files" -ForegroundColor White
Write-Host "  Account: KAKOOZAMICHAEL" -ForegroundColor White
Write-Host ""

$confirm = Read-Host "Push backend files to GitHub now? (y/n)"

if ($confirm -eq 'y') {
    Write-Host ""
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    
    # Check current branch
    $currentBranch = git branch --show-current
    if (-not $currentBranch) {
        git checkout -b main
        $currentBranch = "main"
    }
    
    # Push using git (GitHub CLI handles authentication)
    git push -u origin $currentBranch
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "  ✅ SUCCESS!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Backend files successfully uploaded!" -ForegroundColor Green
        Write-Host ""
        Write-Host "View your repository at:" -ForegroundColor Cyan
        Write-Host "https://github.com/KAKOOZAMICHAEL/contribution-MechKonet-App" -ForegroundColor White
        Write-Host ""
        Write-Host "View backend files at:" -ForegroundColor Cyan
        Write-Host "https://github.com/KAKOOZAMICHAEL/contribution-MechKonet-App/tree/main/backend" -ForegroundColor White
        Write-Host ""
        Write-Host "✅ Upload complete!" -ForegroundColor Green
    }
    else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "  ❌ PUSH FAILED" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Possible issues:" -ForegroundColor Yellow
        Write-Host "  1. Not authenticated as KAKOOZAMICHAEL" -ForegroundColor White
        Write-Host "  2. Repository doesn't exist or no access" -ForegroundColor White
        Write-Host "  3. Network connection issue" -ForegroundColor White
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "  1. Re-authenticate: gh auth login" -ForegroundColor White
        Write-Host "  2. Verify repository exists:" -ForegroundColor White
        Write-Host "     https://github.com/KAKOOZAMICHAEL/contribution-MechKonet-App" -ForegroundColor White
        Write-Host "  3. Try manually: git push -u origin main" -ForegroundColor White
    }
}
else {
    Write-Host ""
    Write-Host "Push cancelled." -ForegroundColor Yellow
    Write-Host "When ready, run: git push -u origin main" -ForegroundColor White
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
