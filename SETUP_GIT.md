# Setup Instructions for Pushing Backend Logic to GitHub

## Important: Authentication Required

I cannot push to GitHub on your behalf because authentication is required. You need to use **YOUR GitHub account** to push the files.

## Quick Setup

### Option 1: Use the PowerShell Script (Recommended)

1. Open PowerShell in your project folder
2. Run: `.\PUSH_TO_GITHUB.ps1`
3. Follow the prompts to configure git and push

### Option 2: Manual Setup

#### Step 1: Configure Git (if not already done)

```bash
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

#### Step 2: Verify Remote Repository

```bash
git remote -v
```

Should show:

```
origin  https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7.git (fetch)
origin  https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7.git (push)
```

#### Step 3: Add and Commit Files

```bash
git add backend/
git commit -m "Add complete backend logic for MechKonect application"
```

#### Step 4: Push to GitHub

```bash
# Try main branch first
git push origin main

# If that doesn't work, try master
git push origin master

# If branch doesn't exist, create it
git checkout -b main
git push -u origin main
```

## Authentication Methods

### Method 1: GitHub CLI (Easiest)

1. Install GitHub CLI: https://cli.github.com/
2. Run: `gh auth login`
3. Follow the prompts
4. Then push: `git push origin main`

### Method 2: Personal Access Token

1. Go to: https://github.com/settings/tokens
2. Generate a new token with `repo` permissions
3. When prompted for password, use the token instead
4. Push: `git push origin main`

### Method 3: SSH Keys

1. Generate SSH key: `ssh-keygen -t ed25519 -C "your.email@example.com"`
2. Add to GitHub: https://github.com/settings/keys
3. Change remote to SSH: `git remote set-url origin git@github.com:DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7.git`
4. Push: `git push origin main`

## Verify Upload

After pushing, check:
https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7

You should see the `backend/` folder with all files.

## Current Status

✅ All backend files are ready locally in `backend/` folder:

- 15 Dart files (models, repositories, services)
- API endpoints configuration
- Seed data
- README documentation

❌ Files need to be pushed using YOUR GitHub account credentials

## Need Help?

If you encounter errors:

1. Check you're logged into GitHub
2. Verify you have write access to the repository
3. Check which branch exists: `git ls-remote --heads origin`
4. Try the PowerShell script: `.\PUSH_TO_GITHUB.ps1`

