# 🚀 Quick Debug Guide - AkScore Project

## 🎯 **Ready to Run & Debug!**

Your project is now fully configured for VS Code debugging. Here's how to get started:

### **Step 1: Open VS Code**
1. **Open VS Code** in your `akscore` folder
2. **Wait for Flutter extension** to load
3. **Check bottom status bar** - should show "Flutter" and device

### **Step 2: Start Debugging**
**Option A: VS Code Debug (Recommended)**
1. **Press `F5`** or click the **Debug** button (▶️)
2. **Select platform** from dropdown:
   - **🌐 AkScore - Chrome Debug** (Fastest)
   - **🖥️ AkScore - Windows Debug** (Desktop)
   - **🌐 AkScore - Edge Debug** (Alternative web)

**Option B: Terminal**
```powershell
flutter run -d chrome
```

### **Step 3: Debug Features**
- **Set Breakpoints** - Click left margin next to line numbers
- **Hot Reload** - `Ctrl+S` (saves and reloads instantly)
- **Step Through Code** - F10, F11, Shift+F11
- **Debug Console** - View logs and execute code
- **Variable Inspection** - Hover over variables

## 🔧 **Debugging Controls**

| Key | Action |
|-----|--------|
| `F5` | Start Debugging |
| `Shift+F5` | Stop Debugging |
| `Ctrl+S` | Hot Reload |
| `F9` | Toggle Breakpoint |
| `F10` | Step Over |
| `F11` | Step Into |
| `Shift+F11` | Step Out |

## 📱 **Your App Features**

### **What's Working:**
- ✅ **Splash Screen** - Animated loading
- ✅ **Home Screen** - Main navigation
- ✅ **Favorites** - Save teams/matches
- ✅ **Settings** - Theme switching
- ✅ **Theme Provider** - Light/Dark mode
- ✅ **Navigation** - Bottom navigation bar
- ✅ **Responsive UI** - Works on all screen sizes

### **Screens Available:**
1. **Splash Screen** - Animated loading (3 seconds)
2. **Home Screen** - Main dashboard
3. **Favorites Screen** - Saved items
4. **Settings Screen** - App preferences
5. **Login Screen** - Authentication (Firebase disabled)
6. **Signup Screen** - User registration

## 🎮 **Testing Your App**

### **Test Navigation:**
1. **Splash Screen** → Auto-navigates to Home
2. **Bottom Navigation** → Switch between screens
3. **Settings** → Toggle dark/light theme
4. **Favorites** → Add/remove items

### **Test Debugging:**
1. **Set breakpoint** in `splash_screen.dart` line 44
2. **Start debugging** with F5
3. **Step through** navigation logic
4. **Check variables** in Debug Console

## 🚀 **Quick Start Commands**

### **Run in VS Code:**
1. **Open VS Code** in project folder
2. **Press F5**
3. **Select "AkScore - Chrome Debug"**
4. **Your app launches in Chrome!**

### **Run in Terminal:**
```powershell
# Chrome (Recommended)
flutter run -d chrome

# Windows Desktop
flutter run -d windows

# Edge Browser
flutter run -d edge
```

## 🔧 **Troubleshooting**

### **If VS Code Debugging Won't Start:**
1. **Check Flutter extension** is installed
2. **Restart VS Code**
3. **Run:** `flutter doctor`
4. **Clean project:** `flutter clean && flutter pub get`

### **If App Won't Compile:**
1. **Check for red underlines** in VS Code
2. **Save all files** (`Ctrl+Shift+S`)
3. **Run:** `flutter analyze`
4. **Check terminal** for error messages

### **If Hot Reload Fails:**
1. **Save file** (`Ctrl+S`)
2. **Use Hot Restart** (`Ctrl+Shift+F5`)
3. **Check for syntax errors**
4. **Restart debugging session**

## 🎉 **You're Ready!**

**Your AkScore project is fully configured and ready to run!**

1. **Open VS Code** in your project
2. **Press F5** to start debugging
3. **Select Chrome** for fastest experience
4. **Your app will launch** with full debugging capabilities!

**Happy Coding! 🚀**
