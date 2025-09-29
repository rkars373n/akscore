#AkScore App

A comprehensive live score application built with Flutter, similar to Aiscore or FotMob, featuring real-time match updates, goal notifications, and a beautiful UI with dark/light theme support.

## Features

### 🏆 Core Features

- **Live Match Scores**: Real-time updates for ongoing matches
- **Match Details**: Comprehensive match information including events, statistics, and lineups
- **Team & Player Stats**: Detailed statistics for teams and individual players
- **Favorites System**: Save favorite matches, teams, and players
- **Push Notifications**: Goal alerts and match reminders
- **Real-time Data Sync**: Live updates via WebSocket connections

### 🎨 UI/UX Features

- **Dark/Light Theme**: Toggle between themes with persistent settings
- **Clean Modern UI**: Beautiful, intuitive interface
- **Responsive Design**: Optimized for all screen sizes
- **Loading States**: Smooth loading animations and shimmer effects
- **Error Handling**: Graceful error states with retry options

### 📱 Navigation

- **Tab-based Navigation**: Live, Today, and Favorites tabs
- **Match Details**: Detailed match view with events timeline
- **Team Details**: Team information, statistics, and player roster
- **Player Profiles**: Individual player statistics and performance charts
- **Settings**: Customizable notifications and preferences

## Architecture

### State Management

- **Provider Pattern**: For state management across the app
- **Theme Provider**: Manages dark/light theme switching
- **Matches Provider**: Handles match data and API calls

### Services

- **API Service**: Handles HTTP requests and data fetching
- **Notification Service**: Manages push notifications and alerts
- **Realtime Service**: WebSocket connections for live updates
- **Favorites Service**: Local storage for user preferences

### Data Models

- **Match**: Match information, scores, events, and status
- **Team**: Team details, statistics, and player roster
- **Player**: Individual player information and performance stats

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd first_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Configuration

#### API Configuration

The application uses two APIs for data:

- **football-data.org**: For basic match and team data.
- **api-football (RapidAPI)**: For detailed team and player statistics.

The API keys have been configured in `lib/services/real_api_service.dart`. If you need to change them, you can do so in that file.

#### Notification Setup

Configure push notifications for your platform:

**Android**: Add notification permissions to `android/app/src/main/AndroidManifest.xml`

**iOS**: Add notification permissions to `ios/Runner/Info.plist`

## Project Structure

```
- CHANGELOG.md
- Could
- README.md
- analysis_options.yaml
- firebase-debug.log
- firebase.json
- pubspec.lock
- pubspec.yaml
- .idx/
  - dev.nix
  - mcp.json
- .vscode/
  - launch.json
  - settings.json
- android/
  - build.gradle.kts
  - gradle.properties
  - settings.gradle.kts
  - app/
    - build.gradle.kts
    - google-services.json
    - src/
      - debug/AndroidManifest.xml
      - main/
        - AndroidManifest.xml
        - java/io/flutter/plugins/GeneratedPluginRegistrant.java
        - kotlin/com/example/akscore/MainActivity.kt
        - res/
          - drawable/launch_background.xml
          - drawable-v21/launch_background.xml
          - mipmap-hdpi/ic_launcher.png
          - mipmap-mdpi/ic_launcher.png
          - mipmap-xhdpi/ic_launcher.png
          - mipmap-xxhdpi/ic_launcher.png
          - mipmap-xxxhdpi/ic_launcher.png
          - values/styles.xml
          - values-night/styles.xml
      - profile/AndroidManifest.xml
  - gradle/wrapper/
    - gradle-wrapper.jar
    - gradle-wrapper.properties
- assets/
  - data/db.json
  - ml/smartreply.tflite
- build/
  - 1b937ddf1f24d57bfe5a30c4ee137dee/
    - _composite.stamp
    - gen_dart_plugin_registrant.stamp
    - gen_localizations.stamp
  - flutter_assets/
    - AssetManifest.bin
    - AssetManifest.bin.json
    - AssetManifest.json
    - FontManifest.json
    - NOTICES
    - assets/
      - data/db.json
      - ml/smartreply.tflite
    - fonts/MaterialIcons-Regular.otf
    - packages/
      - cupertino_icons/assets/CupertinoIcons.ttf
      - font_awesome_flutter/lib/fonts/
        - Font Awesome 7 Brands-Regular-400.otf
        - Font Awesome 7 Free-Regular-400.otf
        - Font Awesome 7 Free-Solid-900.otf
    - shaders/ink_sparkle.frag
- ios/
  - Flutter/
    - AppFrameworkInfo.plist
    - Debug.xcconfig
    - Release.xcconfig
  - akscore/
    - AppDelegate.swift
    - Assets.xcassets/
      - AppIcon.appiconset/
        - Contents.json
        - Icon-App-1024x1024@1x.png
        - Icon-App-20x20@1x.png
        - Icon-App-20x20@2x.png
        - Icon-App-20x20@3x.png
        - Icon-App-29x29@1x.png
        - Icon-App-29x29@2x.png
        - Icon-App-29x29@3x.png
        - Icon-App-40x40@1x.png
        - Icon-App-40x40@2x.png
        - Icon-App-40x40@3x.png
        - Icon-App-60x60@2x.png
        - Icon-App-60x60@3x.png
        - Icon-App-76x76@1x.png
        - Icon-App-76x76@2x.png
        - Icon-App-83.5x83.5@2x.png
      - LaunchImage.imageset/
        - Contents.json
        - LaunchImage.png
        - LaunchImage@2x.png
        - LaunchImage@3x.png
        - README.md
    - Base.lproj/
      - LaunchScreen.storyboard
      - Main.storyboard
    - GeneratedPluginRegistrant.h
    - GeneratedPluginRegistrant.m
    - Info.plist
    - Runner-Bridging-Header.h
  - akscore.xcodeproj/
    - project.pbxproj
    - project.xcworkspace/
      - contents.xcworkspacedata
      - xcshareddata/
        - IDEWorkspaceChecks.plist
        - WorkspaceSettings.xcsettings
    - xcshareddata/xcschemes/akscore.xcscheme
  - akscore.xcworkspace/
    - contents.xcworkspacedata
    - xcshareddata/
      - IDEWorkspaceChecks.plist
      - WorkspaceSettings.xcsettings
- lib/
  - firebase_options.dart
  - main.dart
  - models/
    - favorite.dart
    - favorite.g.dart
    - match.dart
    - match.g.dart
    - player.dart
    - player.g.dart
    - team.dart
    - team.g.dart
  - providers/
    - matches_provider.dart
    - players_provider.dart
    - teams_provider.dart
    - theme_provider.dart
  - screens/
    - favorites_screen.dart
    - home_screen.dart
    - login_screen.dart
    - match_details_screen.dart
    - player_details_screen.dart
    - settings_screen.dart
    - splash_screen.dart
    - team_details_screen.dart
  - services/
    - fake_api_service.dart
    - favorites_service.dart
    - isar_service.dart
    - notification_service.dart
    - real_api_service.dart
    - realtime_service.dart
    - smart_reply_service.dart
  - utils/json_utils.dart
  - widgets/
    - chat_widget.dart
    - loading_shimmer.dart
    - match_card.dart
    - match_event_card.dart
    - match_statistics_card.dart
    - player_card.dart
    - team_card.dart
- linux/
  - CMakeLists.txt
  - flutter/
    - CMakeLists.txt
    - generated_plugin_registrant.cc
    - generated_plugin_registrant.h
    - generated_plugins.cmake
  - runner/
    - CMakeLists.txt
    - main.cc
    - my_application.cc
    - my_application.h
- macos/
  - Flutter/
    - Flutter-Debug.xcconfig
    - Flutter-Release.xcconfig
    - GeneratedPluginRegistrant.swift
  - Runner/
    - AppDelegate.swift
    - Assets.xcassets/
      - AppIcon.appiconset/
        - Contents.json
        - app_icon_1024.png
        - app_icon_128.png
        - app_icon_16.png
        - app_icon_256.png
        - app_icon_32.png
        - app_icon_512.png
        - app_icon_64.png
    - Base.lproj/MainMenu.xib
    - Configs/
      - AppInfo.xcconfig
      - Debug.xcconfig
      - Release.xcconfig
      - Warnings.xcconfig
    - DebugProfile.entitlements
    - Info.plist
    - MainFlutterWindow.swift
    - Release.entitlements
  - Runner.xcodeproj/
    - project.pbxproj
    - project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
    - xcshareddata/xcschemes/Runner.xcscheme
  - Runner.xcworkspace/contents.xcworkspacedata
- test/
  - widget_test.dart
  - widget_test.mocks.dart
- web/
  - favicon.png
  - icons/
    - Icon-192.png
    - Icon-512.png
    - Icon-maskable-192.png
    - Icon-maskable-512.png
  - index.html
  - manifest.json
- windows/
  - CMakeLists.txt
  - flutter/
    - CMakeLists.txt
    - generated_plugin_registrant.cc
    - generated_plugin_registrant.h
    - generated_plugins.cmake
  - runner/
    - CMakeLists.txt
    - Runner.rc
    - flutter_window.cpp
    - flutter_window.h
    - main.cpp
    - resource.h
    - runner.exe.manifest
    - utils.cpp
    - utils.h
    - win32_window.cpp
    - win32_window.h
```

## Key Dependencies

- **provider**: State management
- **http**: HTTP requests
- **cached_network_image**: Image caching
- **shimmer**: Loading animations
- **flutter_local_notifications**: Push notifications
- **web_socket_channel**: Real-time updates
- **shared_preferences**: Local storage
- **font_awesome_flutter**: Icons

## Features in Detail

### Live Matches

- Real-time score updates
- Live match events (goals, cards, substitutions)
- Match status indicators
- Team logos and information

### Match Details

- Comprehensive match information
- Event timeline with timestamps
- Team statistics and performance
- Venue and referee information

### Team & Player Stats

- Season statistics
- Performance charts
- Player profiles with detailed stats
- Team roster and information

### Notifications

- Goal notifications
- Match start/end alerts
- Customizable reminder settings
- Push notification management

### Favorites

- Save favorite matches
- Follow favorite teams
- Track favorite players
- Persistent storage

## Customization

### Themes

The app supports both light and dark themes with customizable colors:

```dart
// lib/providers/theme_provider.dart
ThemeData get lightTheme => ThemeData(
  primarySwatch: Colors.blue,
  // ... theme configuration
);
```

### API Integration

The app is already integrated with `football-data.org` and `api-football`. You can modify the `ApiService` class in `lib/services/real_api_service.dart` if you want to change the API endpoints or parsing logic.

### Notifications

Configure notifications for your specific use case:

```dart
// lib/services/notification_service.dart
await _notifications.show(
  matchId.hashCode,
  'GOAL! $scorer',
  '$team scored in the $minute' minute',
  details,
);
```
