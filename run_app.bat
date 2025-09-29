@echo off
echo Starting AkScore App...
echo.

REM Check if Flutter is available
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Flutter not found. Please install Flutter and add it to PATH.
    pause
    exit /b 1
)

echo Flutter found. Checking available devices...
echo.

REM Check available devices
flutter devices

echo.
echo Choose your platform:
echo 1. Web (Chrome) - Fastest for testing
echo 2. Windows Desktop
echo 3. Check for Android devices
echo.

set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" (
    echo Starting on Chrome...
    flutter run -d chrome
) else if "%choice%"=="2" (
    echo Starting on Windows...
    flutter run -d windows
) else if "%choice%"=="3" (
    echo Checking for Android devices...
    flutter devices
    echo.
    echo If you see Android devices, run: flutter run
) else (
    echo Invalid choice. Starting on Chrome by default...
    flutter run -d chrome
)

echo.
echo App execution completed.
pause

