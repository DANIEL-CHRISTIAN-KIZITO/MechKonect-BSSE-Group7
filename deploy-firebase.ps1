# Firebase Deployment Script for MechKonect Flutter App
# This script automates the deployment process to Firebase

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "MechKonect Firebase Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Firebase CLI is installed
Write-Host "Checking Firebase CLI..." -ForegroundColor Yellow
$firebaseVersion = npx firebase --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Firebase CLI not found. Installing..." -ForegroundColor Red
    npm install -g firebase-tools
    $firebaseVersion = npx firebase --version
} else {
    Write-Host "Firebase CLI version: $firebaseVersion" -ForegroundColor Green
}

# Check Firebase login status
Write-Host "`nChecking Firebase login status..." -ForegroundColor Yellow
npx firebase login:list | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Not logged in. Please login to Firebase..." -ForegroundColor Yellow
    npx firebase login
}

# Menu for deployment options
Write-Host "`nSelect deployment option:" -ForegroundColor Cyan
Write-Host "1. Deploy Mobile App to Firebase App Distribution (APK)" -ForegroundColor White
Write-Host "2. Deploy Mobile App to Firebase App Distribution (AAB)" -ForegroundColor White
Write-Host "3. Deploy Web App to Firebase Hosting" -ForegroundColor White
Write-Host "4. Build only (no deployment)" -ForegroundColor White
Write-Host "5. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter your choice (1-5)"

switch ($choice) {
    "1" {
        Write-Host "`nBuilding Android APK..." -ForegroundColor Yellow
        flutter build apk --release
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "APK built successfully!" -ForegroundColor Green
            $apkPath = "build\app\outputs\flutter-apk\app-release.apk"
            
            if (Test-Path $apkPath) {
                Write-Host "`nAPK location: $apkPath" -ForegroundColor Green
                Write-Host "`nTo upload to Firebase App Distribution:" -ForegroundColor Yellow
                Write-Host "1. Go to Firebase Console: https://console.firebase.google.com/" -ForegroundColor White
                Write-Host "2. Select project: mechkonect" -ForegroundColor White
                Write-Host "3. Navigate to App Distribution" -ForegroundColor White
                Write-Host "4. Upload the APK file" -ForegroundColor White
                Write-Host "`nOr use CLI command:" -ForegroundColor Yellow
                Write-Host "npx firebase appdistribution:distribute `"$apkPath`" --app YOUR_APP_ID --release-notes `"Your release notes`"" -ForegroundColor Cyan
            }
        } else {
            Write-Host "Build failed!" -ForegroundColor Red
        }
    }
    
    "2" {
        Write-Host "`nBuilding Android App Bundle (AAB)..." -ForegroundColor Yellow
        flutter build appbundle --release
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "AAB built successfully!" -ForegroundColor Green
            $aabPath = "build\app\outputs\bundle\release\app-release.aab"
            
            if (Test-Path $aabPath) {
                Write-Host "`nAAB location: $aabPath" -ForegroundColor Green
                Write-Host "`nTo upload to Firebase App Distribution:" -ForegroundColor Yellow
                Write-Host "1. Go to Firebase Console: https://console.firebase.google.com/" -ForegroundColor White
                Write-Host "2. Select project: mechkonect" -ForegroundColor White
                Write-Host "3. Navigate to App Distribution" -ForegroundColor White
                Write-Host "4. Upload the AAB file" -ForegroundColor White
                Write-Host "`nOr use CLI command:" -ForegroundColor Yellow
                Write-Host "npx firebase appdistribution:distribute `"$aabPath`" --app YOUR_APP_ID --release-notes `"Your release notes`"" -ForegroundColor Cyan
            }
        } else {
            Write-Host "Build failed!" -ForegroundColor Red
        }
    }
    
    "3" {
        Write-Host "`nBuilding Web App..." -ForegroundColor Yellow
        flutter build web --release
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Web build successful!" -ForegroundColor Green
            
            Write-Host "`nDeploying to Firebase Hosting..." -ForegroundColor Yellow
            npx firebase deploy --only hosting
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "`nDeployment successful!" -ForegroundColor Green
                Write-Host "Your app should be live at: https://mechkonect.web.app" -ForegroundColor Cyan
            } else {
                Write-Host "Deployment failed!" -ForegroundColor Red
            }
        } else {
            Write-Host "Build failed!" -ForegroundColor Red
        }
    }
    
    "4" {
        Write-Host "`nWhat would you like to build?" -ForegroundColor Yellow
        Write-Host "1. APK" -ForegroundColor White
        Write-Host "2. AAB" -ForegroundColor White
        Write-Host "3. Web" -ForegroundColor White
        $buildChoice = Read-Host "Enter choice (1-3)"
        
        switch ($buildChoice) {
            "1" {
                flutter build apk --release
            }
            "2" {
                flutter build appbundle --release
            }
            "3" {
                flutter build web --release
            }
        }
    }
    
    "5" {
        Write-Host "Exiting..." -ForegroundColor Yellow
        exit
    }
    
    default {
        Write-Host "Invalid choice!" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Deployment process completed!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

