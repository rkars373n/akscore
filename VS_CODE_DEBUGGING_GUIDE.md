# 🚀 VS Code Debugging Guide for AkScore

## 🎯 **Quick Start - Debug Your App in 3 Steps**

### **Step 1: Open VS Code**
1. **Open VS Code** in your project folder
2. **Press `F5`** or click the **Debug** button (▶️)
3. **Select your platform** from the dropdown

### **Step 2: Choose Your Platform**
- **🌐 Chrome Debug** - Fastest, best for development
- **🖥️ Windows Debug** - Native desktop experience  
- **📱 Android Debug** - Mobile experience (requires emulator)
- **🌐 Edge Debug** - Alternative web browser

### **Step 3: Start Debugging!**
Your app will launch with full debugging capabilities!

## 🔧 **VS Code Debugging Features**

### **Breakpoints & Debugging**
1. **Set Breakpoints** - Click left margin next to line numbers
2. **Step Through Code** - F10 (step over), F11 (step into), Shift+F11 (step out)
3. **Inspect Variables** - Hover over variables or check Debug Console
4. **Call Stack** - See function call hierarchy
5. **Watch Variables** - Add variables to watch list

### **Hot Reload & Hot Restart**
- **Hot Reload** - `Ctrl+S` (saves and reloads instantly)
- **Hot Restart** - `Ctrl+Shift+F5` (full app restart)
- **Stop Debugging** - `Shift+F5`

### **Debug Console**
- **View Logs** - All `print()` and `debugPrint()` statements
- **Execute Code** - Run Dart code while debugging
- **Inspect Objects** - Check variable values

## 🎮 **Debugging Controls**

| Key | Action |
|-----|--------|
| `F5` | Start Debugging |
| `Shift+F5` | Stop Debugging |
| `Ctrl+Shift+F5` | Restart Debugging |
| `F9` | Toggle Breakpoint |
| `F10` | Step Over |
| `F11` | Step Into |
| `Shift+F11` | Step Out |
| `Ctrl+S` | Hot Reload |

## 📱 **Platform-Specific Debugging**

### **Chrome Debug (Recommended)**
- ✅ **Fastest startup**
- ✅ **Best debugging experience**
- ✅ **No emulator needed**
- ✅ **Full web features**

### **Windows Debug**
- ✅ **Native desktop experience**
- ✅ **Windows-specific features**
- ✅ **No browser limitations**

### **Android Debug**
- ✅ **Mobile experience**
- ✅ **Touch gestures**
- ✅ **Device-specific features**
- ⚠️ **Requires Android emulator**

## 🐛 **Common Debugging Scenarios**

### **Debug Login Flow**
1. **Set breakpoint** in `login_screen.dart` line 45
2. **Start debugging** with Chrome
3. **Enter credentials** and click login
4. **Step through** authentication logic
5. **Check variables** in Debug Console

### **Debug State Management**
1. **Set breakpoint** in `auth_provider.dart`
2. **Watch state changes** in real-time
3. **Inspect user data** and error messages
4. **Step through** provider logic

### **Debug API Calls**
1. **Set breakpoint** in `real_api_service.dart`
2. **Watch network requests**
3. **Check response data**
4. **Debug error handling**

## 🔍 **Advanced Debugging**

### **Conditional Breakpoints**
1. **Right-click** on breakpoint
2. **Select "Edit Breakpoint"**
3. **Add condition** (e.g., `user != null`)
4. **Breakpoint only triggers** when condition is true

### **Logpoints**
1. **Right-click** on line
2. **Select "Add Logpoint"**
3. **Enter message** (e.g., `User: {user.name}`)
4. **Logs without stopping** execution

### **Exception Breakpoints**
1. **Go to Breakpoints panel**
2. **Check "All Exceptions"**
3. **App will break** on any exception

## 🚀 **Performance Debugging**

### **Profile Mode**
1. **Select "AkScore - Profile Mode"** from debug dropdown
2. **Run performance analysis**
3. **Check frame rates** and memory usage
4. **Optimize** based on results

### **Release Mode**
1. **Select "AkScore - Release Mode"** from debug dropdown
2. **Test production-like** performance
3. **Check final** app behavior

## 🎯 **Debugging Your AkScore App**

### **Key Areas to Debug**
1. **Authentication Flow** - Login/signup process
2. **API Integration** - Data fetching and caching
3. **State Management** - Provider state changes
4. **Navigation** - Screen transitions
5. **Notifications** - Push notification handling

### **Debugging Tips**
- **Start with Chrome** for fastest debugging
- **Use hot reload** for quick iterations
- **Set breakpoints** at key decision points
- **Watch console** for error messages
- **Test on multiple platforms** before release

## 🔧 **Troubleshooting**

### **If Debugging Won't Start**
1. **Check Flutter Doctor** - `flutter doctor`
2. **Restart VS Code**
3. **Clean project** - `flutter clean`
4. **Get dependencies** - `flutter pub get`

### **If Breakpoints Don't Work**
1. **Ensure you're in debug mode** (not release)
2. **Check file is saved** (`Ctrl+S`)
3. **Restart debugging session**
4. **Verify breakpoint is in executable code**

### **If Hot Reload Fails**
1. **Check for syntax errors**
2. **Save all files** (`Ctrl+Shift+S`)
3. **Use Hot Restart** (`Ctrl+Shift+F5`)
4. **Restart debugging session**

## 🎉 **You're Ready to Debug!**

1. **Press `F5`** to start debugging
2. **Choose your platform** (Chrome recommended)
3. **Set breakpoints** where needed
4. **Step through your code**
5. **Watch your app come to life!**

**Happy Debugging! 🚀**
