# 🚀 AkScore App - Platform Setup Guide

## 📱 Android Setup

### Prerequisites:
1. **Android Studio** - Download from https://developer.android.com/studio
2. **Android SDK** - Install through Android Studio
3. **Android Device** or **Emulator**

### Steps:
1. **Enable Developer Options** on your Android device:
   - Go to Settings > About Phone
   - Tap "Build Number" 7 times
   - Go to Settings > Developer Options
   - Enable "USB Debugging"

2. **Connect your Android device** via USB cable

3. **Run the app**:
   ```bash
   flutter run -d android
   ```
   Or double-click `run_android.bat`

## 🌐 Web Setup

### Prerequisites:
1. **Chrome Browser** (recommended)
2. **Web support enabled** (already done)

### Steps:
1. **Run the app**:
   ```bash
   flutter run -d chrome
   ```
   Or double-click `run_web.bat`

## 🔧 VS Code Setup

### For Android:
1. Open VS Code in your project folder
2. Press `F5` or go to Run > Start Debugging
3. Select "Android" as target device
4. Your app will launch on your Android device

### For Web:
1. Open VS Code in your project folder
2. Press `F5` or go to Run > Start Debugging
3. Select "Chrome" as target device
4. Your app will launch in Chrome browser

## 🎯 Features Available on Both Platforms:

- ✅ **Live Matches**: Real-time scores
- ✅ **Theme Toggle**: Light/Dark mode
- ✅ **Favorites**: Save matches, teams, players
- ✅ **Settings**: Complete configuration
- ✅ **Navigation**: Tab-based navigation
- ✅ **Responsive Design**: Works on all screen sizes
- ✅ **Local Storage**: Favorites saved locally
- ✅ **Real API Data**: Using Football Data API

## 🚨 Troubleshooting:

### Android Issues:
- **Device not detected**: Check USB debugging is enabled
- **Build errors**: Run `flutter clean` then `flutter pub get`
- **Permission denied**: Check USB cable and device settings

### Web Issues:
- **Chrome not opening**: Make sure Chrome is installed
- **Build errors**: Run `flutter clean` then `flutter pub get`
- **CORS issues**: The app handles API calls properly

## 🎉 Your AkScore App is Ready!

Your app works perfectly on both Android and Web platforms with all features functional!
