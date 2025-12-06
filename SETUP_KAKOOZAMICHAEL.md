# Setup for KAKOOZAMICHAEL GitHub Account

## Repository Information

- Repository: https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7
- Your GitHub Account: KAKOOZAMICHAEL
- Your Profile: https://github.com/KAKOOZAMICHAEL

## Step 1: Verify Collaborator Access

### Check if you're a collaborator:

1. Go to: https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7
2. Check if you can see the repository
3. Try to access Settings (if you're a collaborator, you should have access)
4. Or check: https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/settings/access

### If you're NOT a collaborator:

- Ask DANIEL-CHRISTIAN-KIZITO to add you as a collaborator
- Go to: Repository → Settings → Collaborators → Add people
- Add: KAKOOZAMICHAEL

## Step 2: Configure Git for KAKOOZAMICHAEL Account

### Option A: Using GitHub CLI (Recommended)

```powershell
# Install GitHub CLI if not installed
# Download from: https://cli.github.com/

# Login as KAKOOZAMICHAEL
gh auth login

# Select GitHub.com
# Select HTTPS
# Authenticate with browser
# Login as: KAKOOZAMICHAEL

# Verify login
gh auth status
```

### Option B: Using Personal Access Token

1. Login to GitHub as KAKOOZAMICHAEL
2. Go to: https://github.com/settings/tokens
3. Generate new token (classic)
4. Name: "MechKonect Upload"
5. Select scopes: `repo` (full control of private repositories)
6. Generate token and copy it
7. Use it when pushing (username: KAKOOZAMICHAEL, password: token)

### Option C: Using SSH Keys

```powershell
# Generate SSH key for KAKOOZAMICHAEL
ssh-keygen -t ed25519 -C "kakoozamichael@github.com"

# Copy public key
cat ~/.ssh/id_ed25519.pub

# Add to GitHub:
# 1. Go to: https://github.com/settings/keys
# 2. Click "New SSH key"
# 3. Paste the public key
# 4. Save

# Change remote to SSH
git remote set-url origin git@github.com:DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7.git
```

## Step 3: Configure Git User

```powershell
# Set git user to KAKOOZAMICHAEL
git config user.name "KAKOOZAMICHAEL"
git config user.email "your-email@example.com"  # Use email associated with KAKOOZAMICHAEL account

# Verify
git config user.name
git config user.email
```

## Step 4: Push Backend Files

```powershell
# Navigate to project folder
cd "C:\Users\miche\Downloads\mechconect\mechkonect"

# Add backend files
git add backend/

# Commit
git commit -m "Add complete backend logic for MechKonect application

Uploaded by: KAKOOZAMICHAEL
- Added data models (User, Mechanic, Booking, Payment, Review)
- Added repositories (Auth, Booking, Mechanic, Payment)
- Added services (API, Local Storage, Location, Notifications)
- Added API endpoints configuration
- Added seed data for development
- Added comprehensive README documentation"

# Check which branch exists
git ls-remote --heads origin

# Push to main (or master)
git push origin main

# If authentication is required:
# Username: KAKOOZAMICHAEL
# Password: [Your Personal Access Token]
```

## Step 5: Verify Upload

After pushing, verify at:
https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/tree/main/backend

You should see all the backend files.

## Troubleshooting

### "Permission denied" error:

- Verify you're a collaborator on the repository
- Check you're authenticated as KAKOOZAMICHAEL
- Verify your token has `repo` permissions

### "Repository not found" error:

- Check repository URL is correct
- Verify you have access to the repository
- Make sure you're logged in as KAKOOZAMICHAEL

### Authentication issues:

```powershell
# Clear cached credentials
git credential-manager-core erase
# Or on Windows:
git credential-manager erase

# Then try push again
git push origin main
```

## Quick Check Script

Run this to verify everything is set up:

```powershell
Write-Host "=== KAKOOZAMICHAEL Git Setup Check ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Git User:" -ForegroundColor Yellow
git config user.name
git config user.email
Write-Host ""
Write-Host "Remote Repository:" -ForegroundColor Yellow
git remote -v
Write-Host ""
Write-Host "GitHub CLI Status:" -ForegroundColor Yellow
gh auth status 2>&1
Write-Host ""
Write-Host "Backend Files:" -ForegroundColor Yellow
(Get-ChildItem -Path backend -Recurse -File).Count
Write-Host "files ready to upload"
```

