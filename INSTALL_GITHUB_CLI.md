# Install GitHub CLI (gh)

## Option 1: Install via Winget (Recommended for Windows)

```powershell
winget install --id GitHub.cli
```

## Option 2: Install via Chocolatey

```powershell
choco install gh
```

## Option 3: Download Installer

1. Go to: https://cli.github.com/
2. Download Windows installer
3. Run the installer
4. Restart PowerShell

## Option 4: Use Scoop

```powershell
scoop install gh
```

## After Installation

1. **Restart PowerShell** (important!)
2. Verify installation:
   ```powershell
   gh --version
   ```
3. Login:
   ```powershell
   gh auth login
   ```

## Alternative: Use Git with Personal Access Token

If you don't want to install GitHub CLI, you can use git directly with a Personal Access Token.
