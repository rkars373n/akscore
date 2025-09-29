# 💻 PowerShell Commands for AkScore

## ❌ Common Mistake
Don't copy the `$` symbol! It's just a prompt indicator.

## ✅ Correct Commands

### Check Flutter Setup
```powershell
flutter doctor
```

### Check Available Devices
```powershell
flutter devices
```

### Run Your App
```powershell
# Run on Chrome (recommended)
flutter run -d chrome

# Run on Windows desktop
flutter run -d windows

# Run on any available device
flutter run
```

### Install Dependencies
```powershell
flutter pub get
```

### Clean and Rebuild
```powershell
flutter clean
flutter pub get
```

## 🚀 Quick Start

1. **Open PowerShell** in your project folder
2. **Run this command:**
   ```powershell
   flutter run -d chrome
   ```
3. **Your app will open in Chrome browser!**

## 🔧 Troubleshooting

### If "flutter" command not found:
1. **Install Flutter** from https://flutter.dev/docs/get-started/install/windows
2. **Add Flutter to PATH** during installation
3. **Restart PowerShell**

### If no devices found:
- Use `flutter run -d chrome` for web
- Use `flutter run -d windows` for desktop
- Install Android Studio for mobile development

## 📱 Your App Features

Once running, you'll see:
- ✅ Beautiful splash screen
- ✅ Login/signup with Firebase
- ✅ Home screen with navigation
- ✅ Favorites management
- ✅ Theme switching
- ✅ Real-time updates

## 🎯 Ready to Run!

Just type this in PowerShell:
```powershell
flutter run -d chrome
```

No `$` symbol needed! 🚀

