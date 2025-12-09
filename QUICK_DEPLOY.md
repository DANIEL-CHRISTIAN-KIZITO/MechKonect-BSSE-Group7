# Quick Firebase Deployment Guide

## Step 1: Login to Firebase

Run this command to login (will open browser):

```powershell
npx firebase login
```

Or use the automated script:

```powershell
.\deploy-firebase.ps1
```

## Step 2: Build Your App

### For Mobile App Distribution (Testing):

```powershell
# Build APK
flutter build apk --release

# OR Build AAB (recommended for Play Store)
flutter build appbundle --release
```

### For Web Deployment:

```powershell
flutter build web --release
```

## Step 3: Deploy

### Option A: Use Firebase Console (Easiest for App Distribution)

1. Go to: https://console.firebase.google.com/
2. Select project: **mechkonect**
3. Click **App Distribution** in left menu
4. Click **Upload release**
5. Select your APK/AAB file from:
   - APK: `build\app\outputs\flutter-apk\app-release.apk`
   - AAB: `build\app\outputs\bundle\release\app-release.aab`
6. Add release notes and testers
7. Click **Distribute**

### Option B: Use CLI

**For App Distribution:**
```powershell
npx firebase appdistribution:distribute build\app\outputs\flutter-apk\app-release.apk --app YOUR_APP_ID --release-notes "Version 1.0.0"
```

**For Web Hosting:**
```powershell
npx firebase deploy --only hosting
```

## Get Your App ID

1. Go to Firebase Console → Project Settings
2. Scroll to "Your apps" section
3. Find your Android app
4. Copy the App ID (format: `1:986409770944:android:667af696d7e5cd05a87225`)

## Quick Commands Reference

```powershell
# Login
npx firebase login

# Check login status
npx firebase login:list

# Build APK
flutter build apk --release

# Build AAB
flutter build appbundle --release

# Build Web
flutter build web --release

# Deploy Web
npx firebase deploy --only hosting

# List projects
npx firebase projects:list
```

