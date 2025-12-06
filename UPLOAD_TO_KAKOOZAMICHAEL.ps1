# Script to upload backend logic to KAKOOZAMICHAEL's GitHub account
# Run: .\UPLOAD_TO_KAKOOZAMICHAEL.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Upload Backend Logic to KAKOOZAMICHAEL" -ForegroundColor Cyan
Write-Host "  GitHub Account: KAKOOZAMICHAEL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Configure Git User
Write-Host "Step 1: Configuring Git for KAKOOZAMICHAEL..." -ForegroundColor Yellow
git config user.name "KAKOOZAMICHAEL"
Write-Host "✅ Git user set to: KAKOOZAMICHAEL" -ForegroundColor Green

$email = git config user.email
if (-not $email) {
    Write-Host ""
    Write-Host "Enter your GitHub email (for KAKOOZAMICHAEL account):" -ForegroundColor Yellow
    $email = Read-Host "Email"
    git config user.email $email
}
Write-Host "✅ Email: $email" -ForegroundColor Green
Write-Host ""

# Step 2: Check Backend Files
Write-Host "Step 2: Checking backend files..." -ForegroundColor Yellow
if (-not (Test-Path backend)) {
    Write-Host "❌ Backend folder not found!" -ForegroundColor Red
    exit
}

$files = Get-ChildItem -Path backend -Recurse -File
$fileCount = $files.Count
Write-Host "✅ Found $fileCount files in backend folder" -ForegroundColor Green
Write-Host ""

# Step 3: Repository Setup
Write-Host "Step 3: Setting up repository..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Choose repository option:" -ForegroundColor Cyan
Write-Host "  1. Create new repository on KAKOOZAMICHAEL account" -ForegroundColor White
Write-Host "  2. Push to existing repository" -ForegroundColor White
Write-Host "  3. Use current remote (if already set)" -ForegroundColor White
Write-Host ""

$option = Read-Host "Select option (1/2/3)"

$repoName = ""
$repoUrl = ""

if ($option -eq "1") {
    Write-Host ""
    Write-Host "Creating new repository..." -ForegroundColor Yellow
    $repoName = Read-Host "Enter repository name (e.g., MechKonect-Backend)"
    
    if (-not $repoName) {
        $repoName = "MechKonect-Backend"
        Write-Host "Using default name: $repoName" -ForegroundColor Yellow
    }
    
    $repoUrl = "https://github.com/KAKOOZAMICHAEL/$repoName.git"
    
    Write-Host ""
    Write-Host "⚠️  You need to create the repository on GitHub first:" -ForegroundColor Yellow
    Write-Host "  1. Go to: https://github.com/new" -ForegroundColor White
    Write-Host "  2. Repository name: $repoName" -ForegroundColor White
    Write-Host "  3. Make it Public or Private (your choice)" -ForegroundColor White
    Write-Host "  4. DO NOT initialize with README, .gitignore, or license" -ForegroundColor White
    Write-Host "  5. Click 'Create repository'" -ForegroundColor White
    Write-Host ""
    $created = Read-Host "Have you created the repository? (y/n)"
    
    if ($created -ne 'y') {
        Write-Host "Please create the repository first, then run this script again." -ForegroundColor Red
        exit
    }
    
    # Remove existing remote if any
    $existingRemote = git remote get-url origin 2>$null
    if ($existingRemote) {
        Write-Host "Removing existing remote..." -ForegroundColor Yellow
        git remote remove origin
    }
    
    git remote add origin $repoUrl
    Write-Host "✅ Remote set to: $repoUrl" -ForegroundColor Green
    
} elseif ($option -eq "2") {
    Write-Host ""
    $repoName = Read-Host "Enter repository name (e.g., MechKonect-Backend)"
    $repoUrl = "https://github.com/KAKOOZAMICHAEL/$repoName.git"
    
    # Remove existing remote if any
    $existingRemote = git remote get-url origin 2>$null
    if ($existingRemote) {
        Write-Host "Removing existing remote..." -ForegroundColor Yellow
        git remote remove origin
    }
    
    git remote add origin $repoUrl
    Write-Host "✅ Remote set to: $repoUrl" -ForegroundColor Green
    
} else {
    $existingRemote = git remote get-url origin 2>$null
    if ($existingRemote) {
        Write-Host "✅ Using existing remote: $existingRemote" -ForegroundColor Green
        $repoUrl = $existingRemote
    } else {
        Write-Host "❌ No remote configured!" -ForegroundColor Red
        Write-Host "Please select option 1 or 2 to set up a repository." -ForegroundColor Yellow
        exit
    }
}

Write-Host ""

# Step 4: Initialize Git (if needed)
if (-not (Test-Path .git)) {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
    Write-Host ""
}

# Step 5: Add and Commit
Write-Host "Step 4: Preparing files..." -ForegroundColor Yellow
$status = git status --porcelain backend/ 2>$null

if ($status -or -not (git log --oneline -1 2>$null)) {
    Write-Host "Adding backend files..." -ForegroundColor Yellow
    git add backend/
    Write-Host "✅ Files added" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Committing files..." -ForegroundColor Yellow
    $commitMessage = @"
Add complete backend logic for MechKonect application

- Data models (User, Mechanic, Booking, Payment, Review)
- Repositories (Auth, Booking, Mechanic, Payment)
- Services (API, Local Storage, Location, Notifications)
- API endpoints configuration
- Seed data for development
- Comprehensive README documentation

Uploaded by: KAKOOZAMICHAEL
"@
    
    git commit -m $commitMessage
    Write-Host "✅ Files committed" -ForegroundColor Green
} else {
    Write-Host "Files already committed" -ForegroundColor Yellow
}

Write-Host ""

# Step 6: Authenticate
Write-Host "Step 5: Authentication..." -ForegroundColor Yellow
Write-Host ""
Write-Host "⚠️  IMPORTANT: You need to authenticate as KAKOOZAMICHAEL" -ForegroundColor Yellow
Write-Host ""

# Check GitHub CLI
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue
if ($ghInstalled) {
    $ghStatus = gh auth status 2>&1
    if ($LASTEXITCODE -eq 0) {
        $ghUser = gh api user --jq .login 2>$null
        if ($ghUser -eq "KAKOOZAMICHAEL") {
            Write-Host "✅ Authenticated as KAKOOZAMICHAEL via GitHub CLI" -ForegroundColor Green
        } else {
            Write-Host "⚠️  Currently logged in as: $ghUser" -ForegroundColor Yellow
            Write-Host "You need to login as KAKOOZAMICHAEL" -ForegroundColor Yellow
            Write-Host ""
            $login = Read-Host "Login as KAKOOZAMICHAEL now? (y/n)"
            if ($login -eq 'y') {
                gh auth login
            }
        }
    } else {
        Write-Host "⚠️  Not authenticated with GitHub CLI" -ForegroundColor Yellow
        Write-Host ""
        $login = Read-Host "Login to GitHub CLI as KAKOOZAMICHAEL? (y/n)"
        if ($login -eq 'y') {
            gh auth login
        }
    }
} else {
    Write-Host "GitHub CLI not installed." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You can:" -ForegroundColor Cyan
    Write-Host "  1. Install GitHub CLI: https://cli.github.com/" -ForegroundColor White
    Write-Host "  2. Use Personal Access Token when pushing" -ForegroundColor White
    Write-Host ""
    Write-Host "Get token at: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host "  - Generate new token (classic)" -ForegroundColor White
    Write-Host "  - Select scope: repo" -ForegroundColor White
    Write-Host "  - Use token as password when pushing" -ForegroundColor White
}

Write-Host ""

# Step 7: Push
Write-Host "Step 6: Ready to push!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Git User: KAKOOZAMICHAEL" -ForegroundColor White
Write-Host "  Repository: $repoUrl" -ForegroundColor White
Write-Host "  Files: $fileCount files" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  When prompted for credentials:" -ForegroundColor Yellow
Write-Host "  Username: KAKOOZAMICHAEL" -ForegroundColor White
Write-Host "  Password: [Your Personal Access Token - NOT your password]" -ForegroundColor White
Write-Host ""

$confirm = Read-Host "Push to GitHub now? (y/n)"

if ($confirm -eq 'y') {
    Write-Host ""
    Write-Host "Pushing to KAKOOZAMICHAEL's GitHub..." -ForegroundColor Yellow
    Write-Host ""
    
    # Try to push to main branch
    git push -u origin main 2>&1 | Tee-Object -Variable pushOutput
    
    if ($LASTEXITCODE -ne 0) {
        # Try master branch
        Write-Host ""
        Write-Host "Trying 'master' branch..." -ForegroundColor Yellow
        git push -u origin master 2>&1 | Tee-Object -Variable pushOutput2
        
        if ($LASTEXITCODE -ne 0) {
            # Create and push to main
            Write-Host ""
            Write-Host "Creating 'main' branch..." -ForegroundColor Yellow
            git checkout -b main 2>$null
            git push -u origin main 2>&1 | Tee-Object -Variable pushOutput3
        }
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "  ✅ SUCCESS!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Backend logic successfully uploaded to KAKOOZAMICHAEL's GitHub!" -ForegroundColor Green
        Write-Host ""
        
        if ($repoUrl) {
            $repoName = ($repoUrl -split '/')[-1] -replace '\.git$', ''
            Write-Host "View your repository at:" -ForegroundColor Cyan
            Write-Host "https://github.com/KAKOOZAMICHAEL/$repoName" -ForegroundColor White
            Write-Host ""
            Write-Host "View backend files at:" -ForegroundColor Cyan
            Write-Host "https://github.com/KAKOOZAMICHAEL/$repoName/tree/main/backend" -ForegroundColor White
        }
        
        Write-Host ""
        Write-Host "✅ Commit author: KAKOOZAMICHAEL" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "  ❌ PUSH FAILED" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Possible issues:" -ForegroundColor Yellow
        Write-Host "  1. Authentication failed" -ForegroundColor White
        Write-Host "  2. Repository doesn't exist or wrong name" -ForegroundColor White
        Write-Host "  3. Wrong credentials" -ForegroundColor White
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "  1. Login with GitHub CLI: gh auth login" -ForegroundColor White
        Write-Host "  2. Use Personal Access Token (not password)" -ForegroundColor White
        Write-Host "  3. Verify repository exists: https://github.com/KAKOOZAMICHAEL" -ForegroundColor White
        Write-Host ""
        Write-Host "Try manually:" -ForegroundColor Yellow
        Write-Host "  git push -u origin main" -ForegroundColor White
    }
} else {
    Write-Host ""
    Write-Host "Push cancelled." -ForegroundColor Yellow
    Write-Host "When ready, run: git push -u origin main" -ForegroundColor White
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

