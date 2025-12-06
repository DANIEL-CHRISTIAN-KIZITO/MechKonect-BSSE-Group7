# Quick Start: Upload Backend as KAKOOZAMICHAEL

## Your GitHub Account

- **Username**: KAKOOZAMICHAEL
- **Profile**: https://github.com/KAKOOZAMICHAEL
- **Repository**: https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7

## Fastest Method (3 Steps)

### Step 1: Run the Script

```powershell
.\LOGIN_AND_PUSH.ps1
```

### Step 2: Login When Prompted

The script will guide you to login as KAKOOZAMICHAEL using:

- GitHub CLI (if installed), OR
- Personal Access Token

### Step 3: Confirm Push

Type `y` when asked to push.

## Manual Method (If Script Doesn't Work)

### 1. Configure Git

```powershell
git config user.name "KAKOOZAMICHAEL"
git config user.email "your-email@example.com"
```

### 2. Login to GitHub CLI

```powershell
gh auth login
# Select: GitHub.com → HTTPS → Browser → Login as KAKOOZAMICHAEL
```

### 3. Add and Commit

```powershell
git add backend/
git commit -m "Add complete backend logic (Uploaded by KAKOOZAMICHAEL)"
```

### 4. Push

```powershell
git push origin main
```

## If Authentication Fails

### Option A: Use Personal Access Token

1. Go to: https://github.com/settings/tokens
2. Generate new token (classic)
3. Select scope: `repo`
4. Copy the token
5. When pushing, use:
   - Username: `KAKOOZAMICHAEL`
   - Password: `[paste your token]`

### Option B: Use GitHub CLI

```powershell
gh auth login
# Follow prompts to login as KAKOOZAMICHAEL
```

## Verify Upload

After pushing, check:

- https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/tree/main/backend
- The commit should show **KAKOOZAMICHAEL** as the author

## Need Help?

If you get "Permission denied":

- Verify you're a collaborator on the repository
- Check: https://github.com/DANIEL-CHRISTIAN-KIZITO/MechKonect-BSSE-Group7/settings/access
- If not listed, ask DANIEL-CHRISTIAN-KIZITO to add you

