# Upload Backend Logic to KAKOOZAMICHAEL's GitHub

## Quick Start

### Option 1: Use the Script (Easiest)

```powershell
.\UPLOAD_TO_KAKOOZAMICHAEL.ps1
```

The script will guide you through:
1. Setting git user to KAKOOZAMICHAEL
2. Creating/selecting repository
3. Authenticating as KAKOOZAMICHAEL
4. Pushing backend files

### Option 2: Manual Upload

#### Step 1: Create Repository on GitHub

1. Go to: https://github.com/new
2. Repository name: `MechKonect-Backend` (or any name you prefer)
3. Make it Public or Private
4. **DO NOT** initialize with README, .gitignore, or license
5. Click "Create repository"

#### Step 2: Configure Git

```powershell
git config user.name "KAKOOZAMICHAEL"
git config user.email "your-email@example.com"
```

#### Step 3: Set Remote

```powershell
git remote add origin https://github.com/KAKOOZAMICHAEL/MechKonect-Backend.git
# Replace 'MechKonect-Backend' with your repository name
```

#### Step 4: Add and Commit

```powershell
git add backend/
git commit -m "Add complete backend logic for MechKonect"
```

#### Step 5: Push

```powershell
git push -u origin main
```

When prompted:
- Username: `KAKOOZAMICHAEL`
- Password: `[Your Personal Access Token]` (NOT your password)

## Authentication

### Get Personal Access Token

1. Login to GitHub as KAKOOZAMICHAEL
2. Go to: https://github.com/settings/tokens
3. Click "Generate new token" → "Generate new token (classic)"
4. Name: "MechKonect Upload"
5. Select scope: `repo` (full control)
6. Generate and copy the token
7. Use it as password when pushing

### Or Use GitHub CLI

```powershell
gh auth login
# Select: GitHub.com → HTTPS → Browser → Login as KAKOOZAMICHAEL
```

## Verify Upload

After pushing, check:
- https://github.com/KAKOOZAMICHAEL/[your-repo-name]
- https://github.com/KAKOOZAMICHAEL/[your-repo-name]/tree/main/backend

The commit should show **KAKOOZAMICHAEL** as the author.

## What Gets Uploaded

All files in the `backend/` folder:
- ✅ 15 Dart files (models, repositories, services)
- ✅ API endpoints configuration
- ✅ Seed data
- ✅ README documentation

Total: 17 files

## Troubleshooting

### "Repository not found"
- Verify repository exists on your account
- Check repository name is correct
- Make sure you're logged in as KAKOOZAMICHAEL

### "Authentication failed"
- Use Personal Access Token (not password)
- Verify token has `repo` scope
- Try: `gh auth login` to authenticate

### "Permission denied"
- Make sure you're authenticated as KAKOOZAMICHAEL
- Verify you own the repository
- Check token permissions

