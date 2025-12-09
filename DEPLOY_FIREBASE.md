# Firebase Deployment Guide for MechKonect

This guide will help you deploy your Flutter application to Firebase.

## Prerequisites

- Node.js and npm installed ✅
- Firebase CLI installed ✅
- Firebase project created: `mechkonect`
- Google account with Firebase access

## Step 1: Login to Firebase

Run the following command and follow the prompts:

```bash
firebase login
```

This will open a browser window for you to authenticate with your Google account.

## Step 2: Initialize Firebase (Already Done)

The Firebase configuration files have been created:
- `firebase.json` - Firebase configuration
- `.firebaserc` - Firebase project settings

## Step 3: Deploy Mobile App to Firebase App Distribution

### Build Android APK/AAB

First, build your Flutter app:

```bash
# Build APK (for testing)
flutter build apk --release

# OR Build AAB (for Play Store and App Distribution)
flutter build appbundle --release
```

### Upload to Firebase App Distribution

#### Option A: Using Firebase Console (Easiest)

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `mechkonect`
3. Navigate to **App Distribution** in the left menu
4. Click **Upload release**
5. Select your APK or AAB file from `build/app/outputs/flutter-apk/app-release.apk` or `build/app/outputs/bundle/release/app-release.aab`
6. Add release notes and testers
7. Click **Distribute**

#### Option B: Using Firebase CLI

```bash
# Install Firebase App Distribution plugin
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
  --app YOUR_APP_ID \
  --release-notes "Version 1.0.0 - Initial release" \
  --testers "tester1@example.com,tester2@example.com"
```

To get your App ID:
1. Go to Firebase Console → Project Settings
2. Under "Your apps", find your Android app
3. Copy the App ID

## Step 4: Deploy Web Version to Firebase Hosting (Optional)

If you want to deploy a web version of your Flutter app:

### Build Web Version

```bash
flutter build web --release
```

### Deploy to Firebase Hosting

```bash
firebase deploy --only hosting
```

After deployment, you'll get a URL like: `https://mechkonect.web.app`

## Step 5: Automated Deployment Script

Use the provided PowerShell script for easier deployment:

```powershell
.\deploy-firebase.ps1
```

## Troubleshooting

### Firebase Login Issues
- Make sure you're logged in: `firebase login:list`
- Re-login if needed: `firebase login --reauth`

### Build Issues
- Clean build: `flutter clean && flutter pub get`
- Check Flutter version: `flutter --version`
- Ensure all dependencies are installed: `flutter pub get`

### App Distribution Issues
- Ensure Firebase App Distribution API is enabled in Google Cloud Console
- Check that your app is registered in Firebase Console
- Verify you have the correct App ID

## Next Steps

1. **Set up CI/CD**: Automate deployments using GitHub Actions
2. **Add testers**: Invite team members to test via App Distribution
3. **Monitor crashes**: Set up Firebase Crashlytics
4. **Analytics**: Enable Firebase Analytics for user insights

## Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [Firebase App Distribution](https://firebase.google.com/docs/app-distribution)
- [Firebase Hosting](https://firebase.google.com/docs/hosting)
- [Flutter Firebase Setup](https://firebase.flutter.dev/)

