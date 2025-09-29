# 🔥 Complete Firebase Setup Guide for AkScore

## Current Status ✅
Your app now has Firebase authentication code ready, but you need to set up a real Firebase project to make it work.

## 🚀 Quick Setup (5 minutes)

### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `akscore-app` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

### Step 2: Enable Authentication
1. In your Firebase project, go to **Authentication**
2. Click **Get Started**
3. Go to **Sign-in method** tab
4. Enable **Email/Password** authentication
5. Click **Save**

### Step 3: Enable Firestore Database
1. Go to **Firestore Database**
2. Click **Create database**
3. Choose **Start in test mode** (for development)
4. Select a location (choose closest to you)
5. Click **Done**

### Step 4: Configure Your App

#### Option A: Use FlutterFire CLI (Recommended)
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

#### Option B: Manual Configuration
1. **For Android:**
   - Go to Project Settings → General → Your apps
   - Add Android app with package name: `com.example.akscore`
   - Download `google-services.json`
   - Place it in `android/app/`

2. **For iOS:**
   - Add iOS app with bundle ID: `com.example.akscore`
   - Download `GoogleService-Info.plist`
   - Add it to `ios/Runner/`

3. **For Web:**
   - Add web app
   - Copy the configuration object

### Step 5: Update firebase_options.dart
Replace the demo values in `lib/firebase_options.dart` with your real Firebase configuration:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_REAL_WEB_API_KEY',
  appId: 'YOUR_REAL_WEB_APP_ID',
  messagingSenderId: 'YOUR_REAL_SENDER_ID',
  projectId: 'your-real-project-id',
  authDomain: 'your-real-project-id.firebaseapp.com',
  storageBucket: 'your-real-project-id.appspot.com',
);
```

## 🧪 Testing Your Setup

### 1. Run the App
```bash
flutter run -d android
```

### 2. Test Authentication
1. **Open the app** → You'll see the splash screen
2. **Navigate to login** → Try creating an account
3. **Sign up** with email and password
4. **Sign in** with your credentials
5. **Check Firebase Console** → You should see the user in Authentication

### 3. Test Firestore
1. Go to **Firestore Database** in Firebase Console
2. You should see a `users` collection
3. Each user document should contain:
   - uid, email, displayName
   - createdAt, lastLoginAt
   - favoriteMatches, favoriteTeams, favoritePlayers

## 🔧 Troubleshooting

### Common Issues:

1. **"Firebase project not found"**
   - Check your project ID in firebase_options.dart
   - Ensure the project exists in Firebase Console

2. **"Authentication failed"**
   - Verify Email/Password is enabled in Firebase Console
   - Check your API keys are correct

3. **"Firestore permission denied"**
   - Update Firestore rules in Firebase Console:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if request.auth != null;
       }
     }
   }
   ```

4. **"App not found"**
   - Ensure you've added the app to Firebase project
   - Check package name/bundle ID matches

### Debug Steps:
1. **Check Firebase Console** for errors
2. **Check device logs**: `flutter logs`
3. **Verify configuration** files are in correct locations
4. **Test with Firebase Emulator** for development

## 🚀 Production Setup

### Security Rules
Update Firestore rules for production:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Environment Configuration
- Use different Firebase projects for dev/staging/production
- Store API keys securely
- Enable App Check for additional security

## 📱 Features Now Available

With Firebase properly configured, your app will have:

- ✅ **User Registration** - Create accounts with email/password
- ✅ **User Login** - Sign in with credentials
- ✅ **Password Reset** - Reset passwords via email
- ✅ **User Profiles** - Store user data in Firestore
- ✅ **Session Management** - Automatic login persistence
- ✅ **Data Sync** - Real-time data synchronization
- ✅ **Security** - Firebase handles authentication security

## 🎯 Next Steps

1. **Set up Firebase project** (5 minutes)
2. **Configure your app** (5 minutes)
3. **Test authentication** (2 minutes)
4. **Deploy to production** when ready

Your AkScore app is now ready for real Firebase authentication! 🔥

## 📞 Need Help?

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)

**Total setup time: ~10 minutes** ⏱️
