# LiveScore App

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
lib/
├── models/           # Data models
│   ├── match.dart
│   └── team.dart
├── providers/        # State management
│   ├── theme_provider.dart
│   └── matches_provider.dart
├── screens/         # UI screens
│   ├── home_screen.dart
│   ├── match_details_screen.dart
│   ├── team_details_screen.dart
│   ├── player_details_screen.dart
│   └── settings_screen.dart
├── services/        # Business logic
│   ├── api_service.dart
│   ├── notification_service.dart
│   ├── realtime_service.dart
│   └── favorites_service.dart
├── widgets/         # Reusable components
│   ├── match_card.dart
│   └── loading_shimmer.dart
└── main.dart        # App entry point
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
  '$team scored in the $minute\' minute',
  details,
);
```

## Future Enhancements

- [ ] User authentication and profiles
- [ ] Social features (comments, sharing)
- [ ] Advanced statistics and analytics
- [ ] Multiple league support
- [ ] Offline mode with data caching
- [ ] Widget support for home screen
- [ ] Apple Watch / Wear OS support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please contact [your-email@example.com] or create an issue in the repository.
