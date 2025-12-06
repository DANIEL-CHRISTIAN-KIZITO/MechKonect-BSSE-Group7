# Upload backend logic WITHOUT GitHub CLI
# Uses git directly with Personal Access Token
# Run: .\UPLOAD_WITHOUT_CLI.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Upload Backend Logic" -ForegroundColor Cyan
Write-Host "  (Using Git + Personal Access Token)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Configure Git User
Write-Host "Step 1: Configuring Git for KAKOOZAMICHAEL..." -ForegroundColor Yellow
git config user.name "KAKOOZAMICHAEL"
$email = git config user.email
if (-not $email) {
    Write-Host "Enter your GitHub email (for KAKOOZAMICHAEL account):" -ForegroundColor Yellow
    $email = Read-Host "Email"
    git config user.email $email
}
Write-Host "✅ Git user: KAKOOZAMICHAEL <$email>" -ForegroundColor Green
Write-Host ""

# Step 2: Initialize Git Repository (if needed)
Write-Host "Step 2: Setting up repository..." -ForegroundColor Yellow
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
    } else {
        Write-Host "Adding remote: $targetRepo" -ForegroundColor Yellow
        git remote add origin $targetRepo
    }
    Write-Host "✅ Remote configured" -ForegroundColor Green
} else {
    Write-Host "✅ Remote already set correctly" -ForegroundColor Green
}

Write-Host ""

# Step 3: Check Backend Files
Write-Host "Step 3: Checking backend files..." -ForegroundColor Yellow
if (-not (Test-Path backend)) {
    Write-Host "❌ Backend folder not found!" -ForegroundColor Red
    Write-Host "Make sure you're in the project root directory." -ForegroundColor Yellow
    exit
}

$files = Get-ChildItem -Path backend -Recurse -File
$fileCount = $files.Count
Write-Host "✅ Found $fileCount files in backend folder" -ForegroundColor Green
Write-Host ""

# Step 4: Add and Commit Backend Files
Write-Host "Step 4: Preparing backend files for commit..." -ForegroundColor Yellow
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
} else {
    Write-Host "Files already staged/committed" -ForegroundColor Yellow
}

Write-Host ""

# Step 5: Get Personal Access Token
Write-Host "Step 5: Authentication Setup" -ForegroundColor Yellow
Write-Host ""
Write-Host "⚠️  IMPORTANT: You need a Personal Access Token" -ForegroundColor Yellow
Write-Host ""
Write-Host "To create a token:" -ForegroundColor Cyan
Write-Host "  1. Go to: https://github.com/settings/tokens" -ForegroundColor White
Write-Host "  2. Click 'Generate new token' → 'Generate new token (classic)'" -ForegroundColor White
Write-Host "  3. Name it: 'MechKonect Upload'" -ForegroundColor White
Write-Host "  4. Select scope: 'repo' (full control of private repositories)" -ForegroundColor White
Write-Host "  5. Click 'Generate token'" -ForegroundColor White
Write-Host "  6. COPY THE TOKEN (you won't see it again!)" -ForegroundColor Red
Write-Host ""
Write-Host "Repository: KAKOOZAMICHAEL/contribution-MechKonet-App" -ForegroundColor Cyan
Write-Host ""

# Check current branch
$currentBranch = git branch --show-current
if (-not $currentBranch) {
    git checkout -b main
    $currentBranch = "main"
}

Write-Host "Ready to push to: origin/$currentBranch" -ForegroundColor Cyan
Write-Host ""
$confirm = Read-Host "Do you have your Personal Access Token ready? (y/n)"

if ($confirm -ne 'y') {
    Write-Host ""
    Write-Host "Please create a token first, then run this script again." -ForegroundColor Yellow
    Write-Host "Token creation: https://github.com/settings/tokens" -ForegroundColor Cyan
    exit
}

Write-Host ""
Write-Host "When prompted for credentials:" -ForegroundColor Yellow
Write-Host "  Username: KAKOOZAMICHAEL" -ForegroundColor White
Write-Host "  Password: [Paste your Personal Access Token]" -ForegroundColor White
Write-Host ""
$push = Read-Host "Push to GitHub now? (y/n)"

if ($push -eq 'y') {
    Write-Host ""
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    Write-Host "You will be prompted for credentials." -ForegroundColor Yellow
    Write-Host ""
    
    # Push using git (will prompt for credentials)
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
    } else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "  ❌ PUSH FAILED" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Possible issues:" -ForegroundColor Yellow
        Write-Host "  1. Wrong username (should be: KAKOOZAMICHAEL)" -ForegroundColor White
        Write-Host "  2. Wrong token (check you copied it correctly)" -ForegroundColor White
        Write-Host "  3. Token doesn't have 'repo' scope" -ForegroundColor White
        Write-Host "  4. Repository doesn't exist" -ForegroundColor White
        Write-Host ""
        Write-Host "Solutions:" -ForegroundColor Yellow
        Write-Host "  1. Create new token: https://github.com/settings/tokens" -ForegroundColor White
        Write-Host "  2. Make sure token has 'repo' scope" -ForegroundColor White
        Write-Host "  3. Create repository if it doesn't exist:" -ForegroundColor White
        Write-Host "     https://github.com/new" -ForegroundColor White
        Write-Host "     Name: contribution-MechKonet-App" -ForegroundColor White
        Write-Host ""
        Write-Host "Try again: git push -u origin $currentBranch" -ForegroundColor White
    }
} else {
    Write-Host ""
    Write-Host "Push cancelled." -ForegroundColor Yellow
    Write-Host "When ready, run: git push -u origin $currentBranch" -ForegroundColor White
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
