# Complete script to login as KAKOOZAMICHAEL and push backend files
# Run: .\LOGIN_AND_PUSH.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  MechKonect Backend Upload Script" -ForegroundColor Cyan
Write-Host "  GitHub Account: KAKOOZAMICHAEL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Configure Git User
Write-Host "Step 1: Configuring Git for KAKOOZAMICHAEL..." -ForegroundColor Yellow
$currentUser = git config user.name
if ($currentUser -ne "KAKOOZAMICHAEL") {
    git config user.name "KAKOOZAMICHAEL"
    Write-Host "✅ Git user set to: KAKOOZAMICHAEL" -ForegroundColor Green
} else {
    Write-Host "✅ Git user already set to: KAKOOZAMICHAEL" -ForegroundColor Green
}

$email = git config user.email
if (-not $email) {
    Write-Host ""
    Write-Host "Enter your GitHub email (for KAKOOZAMICHAEL account):" -ForegroundColor Yellow
    $email = Read-Host "Email"
    git config user.email $email
    Write-Host "✅ Email configured" -ForegroundColor Green
} else {
    Write-Host "✅ Email: $email" -ForegroundColor Green
}

Write-Host ""

# Step 2: Check GitHub CLI
Write-Host "Step 2: Checking GitHub CLI authentication..." -ForegroundColor Yellow
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue

if (-not $ghInstalled) {
    Write-Host "⚠️  GitHub CLI not installed" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Install GitHub CLI from: https://cli.github.com/" -ForegroundColor White
    Write-Host "Or continue with manual authentication below" -ForegroundColor White
    Write-Host ""
    $continue = Read-Host "Continue without GitHub CLI? (y/n)"
    if ($continue -ne 'y') {
        exit
    }
} else {
    Write-Host "✅ GitHub CLI installed" -ForegroundColor Green
    
    # Check authentication
    $ghStatus = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "⚠️  Not authenticated with GitHub CLI" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "You need to login as KAKOOZAMICHAEL" -ForegroundColor Yellow
        Write-Host ""
        $login = Read-Host "Login to GitHub CLI now? (y/n)"
        if ($login -eq 'y') {
            Write-Host ""
            Write-Host "Follow the prompts to login as KAKOOZAMICHAEL" -ForegroundColor Cyan
            Write-Host "When asked, select:" -ForegroundColor White
            Write-Host "  - GitHub.com" -ForegroundColor White
            Write-Host "  - HTTPS" -ForegroundColor White
            Write-Host "  - Authenticate via browser" -ForegroundColor White
            Write-Host "  - Login as: KAKOOZAMICHAEL" -ForegroundColor White
            Write-Host ""
            gh auth login
        }
    } else {
        $ghUser = gh api user --jq .login 2>$null
        if ($ghUser -eq "KAKOOZAMICHAEL") {
            Write-Host "✅ Authenticated as KAKOOZAMICHAEL" -ForegroundColor Green
        } else {
            Write-Host "⚠️  Currently logged in as: $ghUser" -ForegroundColor Yellow
            Write-Host "You need to login as KAKOOZAMICHAEL" -ForegroundColor Yellow
            Write-Host ""
            $switch = Read-Host "Switch to KAKOOZAMICHAEL? (y/n)"
            if ($switch -eq 'y') {
                gh auth login
            }
        }
    }
}

Write-Host ""

# Step 3: Verify Remote
Write-Host "Step 3: Verifying remote repository..." -ForegroundColor Yellow
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    git remote add origin https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7.git
    Write-Host "✅ Remote added" -ForegroundColor Green
} else {
    Write-Host "✅ Remote: $remote" -ForegroundColor Green
}

Write-Host ""

# Step 4: Check Backend Files
Write-Host "Step 4: Checking backend files..." -ForegroundColor Yellow
if (-not (Test-Path backend)) {
    Write-Host "❌ Backend folder not found!" -ForegroundColor Red
    exit
}

$files = Get-ChildItem -Path backend -Recurse -File
$fileCount = $files.Count
Write-Host "✅ Found $fileCount files in backend folder" -ForegroundColor Green
Write-Host ""

# Step 5: Add and Commit
Write-Host "Step 5: Preparing files for commit..." -ForegroundColor Yellow
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

Uploaded by: KAKOOZAMICHAEL
- Added data models (User, Mechanic, Booking, Payment, Review)
- Added repositories (Auth, Booking, Mechanic, Payment)
- Added services (API, Local Storage, Location, Notifications)
- Added API endpoints configuration
- Added seed data for development
- Added comprehensive README documentation
"@
    
    git commit -m $commitMessage
    Write-Host "✅ Files committed" -ForegroundColor Green
} else {
    Write-Host "Files already staged/committed" -ForegroundColor Yellow
}

Write-Host ""

# Step 6: Determine Branch
Write-Host "Step 6: Checking remote branches..." -ForegroundColor Yellow
$remoteBranches = git ls-remote --heads origin 2>$null

$branch = "main"
if ($remoteBranches -match "refs/heads/master") {
    $branch = "master"
    Write-Host "✅ Found 'master' branch" -ForegroundColor Green
} elseif ($remoteBranches -match "refs/heads/main") {
    $branch = "main"
    Write-Host "✅ Found 'main' branch" -ForegroundColor Green
} else {
    Write-Host "No remote branches found. Will create 'main' branch." -ForegroundColor Yellow
}

Write-Host ""

# Step 7: Push
Write-Host "Step 7: Ready to push!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Git User: KAKOOZAMICHAEL" -ForegroundColor White
Write-Host "  Repository: DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7" -ForegroundColor White
Write-Host "  Branch: $branch" -ForegroundColor White
Write-Host "  Files: $fileCount files" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  IMPORTANT:" -ForegroundColor Yellow
Write-Host "  - Make sure you're logged in as KAKOOZAMICHAEL" -ForegroundColor White
Write-Host "  - If prompted for credentials:" -ForegroundColor White
Write-Host "    Username: KAKOOZAMICHAEL" -ForegroundColor White
Write-Host "    Password: [Your Personal Access Token - NOT your password]" -ForegroundColor White
Write-Host ""
Write-Host "  Get token at: https://github.com/settings/tokens" -ForegroundColor Cyan
Write-Host ""

$confirm = Read-Host "Push to GitHub now? (y/n)"

if ($confirm -eq 'y') {
    Write-Host ""
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    Write-Host ""
    
    git push -u origin $branch
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "  ✅ SUCCESS!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Backend files successfully uploaded!" -ForegroundColor Green
        Write-Host ""
        Write-Host "View files at:" -ForegroundColor Cyan
        Write-Host "https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/tree/$branch/backend" -ForegroundColor White
        Write-Host ""
        Write-Host "Verify the commit author shows: KAKOOZAMICHAEL" -ForegroundColor Yellow
    } else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "  ❌ PUSH FAILED" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Possible issues:" -ForegroundColor Yellow
        Write-Host "  1. Authentication failed" -ForegroundColor White
        Write-Host "  2. KAKOOZAMICHAEL is not a collaborator" -ForegroundColor White
        Write-Host "  3. Wrong credentials" -ForegroundColor White
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "  1. Login with GitHub CLI: gh auth login" -ForegroundColor White
        Write-Host "  2. Use Personal Access Token (not password)" -ForegroundColor White
        Write-Host "  3. Verify collaborator access:" -ForegroundColor White
        Write-Host "     https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/settings/access" -ForegroundColor White
        Write-Host ""
        Write-Host "Try again manually:" -ForegroundColor Yellow
        Write-Host "  git push -u origin $branch" -ForegroundColor White
    }
} else {
    Write-Host ""
    Write-Host "Push cancelled." -ForegroundColor Yellow
    Write-Host "When ready, run: git push -u origin $branch" -ForegroundColor White
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

