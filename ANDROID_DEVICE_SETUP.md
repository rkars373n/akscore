# 📱 Android Device Setup Guide for AkScore

## Current Issue
You're getting "Device 'android' was not found" because no Android device or emulator is available.

## 🚀 Quick Solutions

### Option 1: Run on Web (Fastest - 30 seconds)
```bash
flutter run -d chrome
```
This will open your app in Chrome browser - perfect for testing!

### Option 2: Run on Windows Desktop
```bash
flutter run -d windows
```
This will create a Windows desktop app.

### Option 3: Set Up Android Emulator (5-10 minutes)

#### Prerequisites:
- **Android Studio** (if not installed)
- **Android SDK** (comes with Android Studio)

#### Steps:

1. **Install Android Studio:**
   - Download from: https://developer.android.com/studio
   - Install with default settings
   - Open Android Studio

2. **Set Up Android SDK:**
   - In Android Studio: Tools → SDK Manager
   - Install Android SDK Platform (API 30+)
   - Install Android SDK Build-Tools
   - Install Android Emulator

3. **Create Virtual Device:**
   - In Android Studio: Tools → AVD Manager
   - Click "Create Virtual Device"
   - Choose a device (e.g., Pixel 4)
   - Download and select a system image (API 30+)
   - Click "Finish"

4. **Start Emulator:**
   - In AVD Manager, click the ▶️ button next to your device
   - Wait for emulator to boot (2-3 minutes first time)

5. **Run Your App:**
   ```bash
   flutter run
   ```

### Option 4: Use Physical Android Device

#### Prerequisites:
- Android device with USB debugging enabled
- USB cable

#### Steps:

1. **Enable Developer Options:**
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Go back to Settings → Developer Options

2. **Enable USB Debugging:**
   - Turn on "USB Debugging"
   - Turn on "Install via USB"

3. **Connect Device:**
   - Connect via USB cable
   - Allow USB debugging when prompted

4. **Run Your App:**
   ```bash
   flutter run
   ```

## 🔧 Troubleshooting

### If Android Studio is not installed:
1. Download from: https://developer.android.com/studio
2. Install with default settings
3. Open Android Studio and follow setup wizard

### If emulator won't start:
1. Check if virtualization is enabled in BIOS
2. Try creating a new AVD with different settings
3. Restart Android Studio

### If device not detected:
1. Check USB cable (try different cable)
2. Install device drivers
3. Restart ADB: `adb kill-server && adb start-server`

## 🚀 Recommended Quick Start

**For immediate testing, use Web:**
```bash
flutter run -d chrome
```

**For Android development, set up emulator:**
1. Install Android Studio
2. Create AVD
3. Start emulator
4. Run: `flutter run`

## 📱 Alternative Platforms

### Web Development
```bash
# Run on Chrome
flutter run -d chrome

# Run on Edge
flutter run -d edge

# Run on any browser
flutter run -d web-server --web-port 8080
```

### Desktop Development
```bash
# Windows
flutter run -d windows

# macOS (if on Mac)
flutter run -d macos

# Linux
flutter run -d linux
```

## 🎯 Your AkScore App Features

Once running, your app will have:
- ✅ **Splash Screen** with animations
- ✅ **Login/Sign Up** with Firebase authentication
- ✅ **Home Screen** with navigation
- ✅ **Favorites** management
- ✅ **Settings** with theme toggle
- ✅ **Real-time** match updates

## 📋 Next Steps

1. **Choose your platform** (Web is fastest for testing)
2. **Run the app** using one of the commands above
3. **Test authentication** by creating an account
4. **Set up Android emulator** for mobile testing

Your AkScore app is ready to run on any platform! 🚀
