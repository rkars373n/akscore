# 🤖 Android Debugging Setup for AkScore

## Prerequisites

### 1. Android Studio Installation
- Download from: https://developer.android.com/studio
- Install Android SDK (API 21+)
- Install Android SDK Build-Tools
- Install Android SDK Platform-Tools

### 2. Android Device Setup
**Option A: Physical Device**
1. Enable Developer Options:
   - Go to Settings > About Phone
   - Tap "Build Number" 7 times
   - Go to Settings > Developer Options
   - Enable "USB Debugging"
   - Enable "Install via USB"

2. Connect device via USB cable
3. Allow USB debugging when prompted

**Option B: Android Emulator**
1. Open Android Studio
2. Go to Tools > AVD Manager
3. Create Virtual Device
4. Choose a device (e.g., Pixel 4)
5. Download and select a system image (API 30+)
6. Start the emulator

## VS Code Debugging Setup

### 1. Launch Configurations
Your `.vscode/launch.json` now includes:
- **akscore (Android Debug)** - Debug mode on Android
- **akscore (Android Profile)** - Profile mode for performance testing
- **akscore (Android Release)** - Release mode for production testing

### 2. How to Debug
1. **Connect Android device** or **start emulator**
2. **Open VS Code** in your project folder
3. **Press F5** or go to Run > Start Debugging
4. **Select "akscore (Android Debug)"** from the dropdown
5. **Your app will launch** on Android with full debugging

### 3. Debugging Features Available
- ✅ **Breakpoints** - Set breakpoints in your Dart code
- ✅ **Step through code** - Step over, into, out of functions
- ✅ **Variable inspection** - View variable values
- ✅ **Call stack** - See function call hierarchy
- ✅ **Hot reload** - Make changes and see them instantly
- ✅ **Hot restart** - Restart app with changes

## Command Line Debugging

### 1. Check Available Devices
```bash
flutter devices
```

### 2. Run on Android
```bash
# Debug mode
flutter run -d android

# Profile mode
flutter run --profile -d android

# Release mode
flutter run --release -d android
```

### 3. Debug with Specific Device
```bash
# List all devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

## Android-Specific Features

### 1. Permissions Added
- `INTERNET` - For API calls
- `ACCESS_NETWORK_STATE` - For network status
- `POST_NOTIFICATIONS` - For push notifications
- `WAKE_LOCK` - For background processing

### 2. Notification Support
- Match notifications
- Scheduled reminders
- Background processing

### 3. Performance Optimizations
- Hardware acceleration enabled
- Optimized for Android 5.0+ (API 21+)
- Efficient memory usage

## Troubleshooting

### Common Issues:

1. **Device not detected**
   - Check USB debugging is enabled
   - Try different USB cable
   - Restart ADB: `adb kill-server && adb start-server`

2. **Build errors**
   - Clean project: `flutter clean`
   - Get dependencies: `flutter pub get`
   - Check Android SDK installation

3. **Permission denied**
   - Check USB debugging settings
   - Allow computer access on device
   - Try different USB port

4. **App crashes on launch**
   - Check device logs: `flutter logs`
   - Verify all dependencies are installed
   - Test on different device/emulator

### Debug Commands:
```bash
# View device logs
flutter logs

# Check Flutter doctor
flutter doctor

# Clean and rebuild
flutter clean && flutter pub get

# Check Android SDK
flutter doctor --android-licenses
```

## Performance Tips

1. **Use Profile Mode** for performance testing
2. **Enable GPU rendering** in developer options
3. **Monitor memory usage** with Android Studio profiler
4. **Test on different screen sizes** and Android versions

## Next Steps

1. **Test the app** on your Android device
2. **Set breakpoints** in critical code sections
3. **Use hot reload** for rapid development
4. **Monitor performance** with Flutter DevTools

Your AkScore app is now ready for Android debugging! 🚀
