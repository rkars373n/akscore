# Firebase Setup Guide for AkScore

## Prerequisites
1. A Google account
2. FlutterFire CLI installed: `dart pub global activate flutterfire_cli`
3. Firebase project created at [Firebase Console](https://console.firebase.google.com/)

## Setup Steps

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `akscore-app` (or your preferred name)
4. Enable Google Analytics (optional)
5. Create project

### 2. Configure Firebase for Flutter
1. Open terminal in your project directory
2. Run: `flutterfire configure`
3. Select your Firebase project
4. Choose platforms (Android, iOS, Web, etc.)
5. The CLI will automatically update your `firebase_options.dart` file

### 3. Manual Configuration (Alternative)
If you prefer manual setup, replace the placeholder values in `lib/firebase_options.dart`:

#### For Web:
```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_ACTUAL_WEB_API_KEY',
  appId: 'YOUR_ACTUAL_WEB_APP_ID',
  messagingSenderId: 'YOUR_ACTUAL_SENDER_ID',
  projectId: 'your-actual-project-id',
  authDomain: 'your-actual-project-id.firebaseapp.com',
  storageBucket: 'your-actual-project-id.appspot.com',
);
```

#### For Android:
1. Go to Project Settings > General > Your apps
2. Add Android app with package name: `com.example.akscore`
3. Download `google-services.json` and place in `android/app/`
4. Update `android/app/build.gradle` with Firebase dependencies

#### For iOS:
1. Go to Project Settings > General > Your apps
2. Add iOS app with bundle ID: `com.example.akscore`
3. Download `GoogleService-Info.plist` and add to `ios/Runner/`
4. Update `ios/Runner/Info.plist` with required configurations

### 4. Enable Required Services
In Firebase Console, enable:
- **Authentication** (for user login)
- **Firestore Database** (for data storage)
- **Cloud Messaging** (for notifications)
- **Realtime Database** (for real-time updates)

### 5. Update Dependencies
Ensure your `pubspec.yaml` includes:
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_messaging: ^14.7.10
  flutter_local_notifications: ^16.3.2
```

### 6. Initialize Firebase in main.dart
Uncomment and update the Firebase initialization:
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const AkScoreApp());
}
```

## Troubleshooting

### Common Issues:
1. **Build errors**: Ensure all Firebase dependencies are properly added
2. **Configuration errors**: Verify API keys and project IDs are correct
3. **Platform-specific issues**: Check platform-specific configuration files
4. **Permission errors**: Ensure proper Firebase rules are set

### Testing Firebase Connection:
```dart
// Add this to test Firebase connection
try {
  await Firebase.initializeApp();
  print('Firebase initialized successfully');
} catch (e) {
  print('Firebase initialization failed: $e');
}
```

## Security Notes
- Never commit real API keys to version control
- Use environment variables for production
- Set up proper Firebase Security Rules
- Regularly rotate API keys

## Next Steps
1. Set up Authentication providers
2. Configure Firestore security rules
3. Set up push notification certificates
4. Test all Firebase services
