@echo off
echo Starting AkScore Android Debug...
echo.

REM Check if Flutter is available
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Flutter not found. Please install Flutter and add it to PATH.
    pause
    exit /b 1
)

echo Flutter found. Starting app...
echo.

REM Run the app in debug mode
flutter run -d android --debug

echo.
echo App execution completed.
pause
