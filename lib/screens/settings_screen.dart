import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/theme_provider.dart';
import '../services/notification_service.dart';
import '../services/favorites_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final NotificationService _notificationService = NotificationService();
  final FavoritesService _favoritesService = FavoritesService();
  
  bool _notificationsEnabled = true;
  bool _goalNotifications = true;
  bool _matchStartNotifications = true;
  bool _matchEndNotifications = true;
  bool _reminderNotifications = true;
  int _reminderMinutes = 15;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await Future.wait([
      _notificationService.getNotificationSetting('notifications_enabled'),
      _notificationService.getNotificationSetting('goal_alerts'),
      _notificationService.getNotificationSetting('match_start_alerts'),
      _notificationService.getNotificationSetting('match_end_alerts'),
      _notificationService.getNotificationSetting('reminder_alerts'),
      _notificationService.getNotificationSetting('reminder_minutes'),
    ]);

    if (mounted) {
      setState(() {
        _notificationsEnabled = settings[0] is bool ? settings[0] as bool : true;
        _goalNotifications = settings[1] is bool ? settings[1] as bool : true;
        _matchStartNotifications = settings[2] is bool ? settings[2] as bool : true;
        _matchEndNotifications = settings[3] is bool ? settings[3] as bool : true;
        _reminderNotifications = settings[4] is bool ? settings[4] as bool : true;
        _reminderMinutes = settings[5] is int ? settings[5] as int : 15;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildThemeSection(),
          _buildNotificationSection(),
          _buildFavoritesSection(),
          _buildAboutSection(),
        ],
      ),
    );
  }

  Widget _buildThemeSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Switch between light and dark themes'),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.setTheme(value);
                  },
                  secondary: Icon(
                    themeProvider.isDarkMode 
                      ? FontAwesomeIcons.moon 
                      : FontAwesomeIcons.sun,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              subtitle: const Text('Receive notifications for your favorite matches'),
              value: _notificationsEnabled,
              onChanged: (value) async {
                setState(() {
                  _notificationsEnabled = value;
                });
                await _notificationService.setNotificationsEnabled(value);
                if (value) {
                  await _notificationService.requestPermissions();
                }
              },
              secondary: const Icon(FontAwesomeIcons.bell),
            ),
            if (_notificationsEnabled) ...[
              SwitchListTile(
                title: const Text('Goal Notifications'),
                subtitle: const Text('Get notified when goals are scored'),
                value: _goalNotifications,
                onChanged: (value) {
                  setState(() {
                    _goalNotifications = value;
                  });
                  _notificationService.setNotificationSetting('goal_alerts', value);
                },
                secondary: const Icon(FontAwesomeIcons.futbol),
              ),
              SwitchListTile(
                title: const Text('Match Start'),
                subtitle: const Text('Get notified when matches begin'),
                value: _matchStartNotifications,
                onChanged: (value) {
                  setState(() {
                    _matchStartNotifications = value;
                  });
                  _notificationService.setNotificationSetting('match_start_alerts', value);
                },
                secondary: const Icon(FontAwesomeIcons.play),
              ),
              SwitchListTile(
                title: const Text('Match End'),
                subtitle: const Text('Get notified when matches finish'),
                value: _matchEndNotifications,
                onChanged: (value) {
                  setState(() {
                    _matchEndNotifications = value;
                  });
                  _notificationService.setNotificationSetting('match_end_alerts', value);
                },
                secondary: const Icon(FontAwesomeIcons.flag),
              ),
              SwitchListTile(
                title: const Text('Match Reminders'),
                subtitle: const Text('Get reminded before matches start'),
                value: _reminderNotifications,
                onChanged: (value) {
                  setState(() {
                    _reminderNotifications = value;
                  });
                  _notificationService.setNotificationSetting('reminder_alerts', value);
                },
                secondary: const Icon(FontAwesomeIcons.clock),
              ),
              if (_reminderNotifications) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reminder Time',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _reminderMinutes.toDouble(),
                        min: 5,
                        max: 60,
                        divisions: 11,
                        label: '$_reminderMinutes minutes',
                        onChanged: (value) {
                          setState(() {
                            _reminderMinutes = value.round();
                          });
                          _notificationService.setNotificationSetting('reminder_minutes', value.round());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Favorites',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, int>>(
              future: _favoritesService.getFavoritesCount(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final counts = snapshot.data!;
                  return Column(
                    children: [
                      _buildFavoriteItem(
                        'Favorite Matches',
                        counts['matches'] ?? 0,
                        FontAwesomeIcons.futbol,
                        () {
                          // Navigate to favorite matches
                        },
                      ),
                      _buildFavoriteItem(
                        'Favorite Teams',
                        counts['teams'] ?? 0,
                        FontAwesomeIcons.users,
                        () {
                          // Navigate to favorite teams
                        },
                      ),
                      _buildFavoriteItem(
                        'Favorite Players',
                        counts['players'] ?? 0,
                        FontAwesomeIcons.user,
                        () {
                          // Navigate to favorite players
                        },
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showClearFavoritesDialog();
                },
                icon: const Icon(FontAwesomeIcons.trash),
                label: const Text('Clear All Favorites'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(String title, int count, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(
        count.toString(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildAboutSection() {
    return const Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              // style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(FontAwesomeIcons.info),
              title: Text('App Version'),
              trailing: Text('1.0.0'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.code),
              title: Text('Developer'),
              trailing: Text('Your Name'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.envelope),
              title: Text('Contact'),
              trailing: Text('your.email@example.com'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.star),
              title: Text('Rate App'),
              trailing: Icon(FontAwesomeIcons.chevronRight),
              // onTap: () {
              //   // Open app store rating
              // },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.share),
              title: Text('Share App'),
              trailing: Icon(FontAwesomeIcons.chevronRight),
              // onTap: () {
              //   // Share app
              // },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearFavoritesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Favorites'),
        content: const Text('Are you sure you want to remove all your favorite matches, teams, and players? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              await _favoritesService.clearAllFavorites();
              if (!mounted) return;
              navigator.pop();
              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text('All favorites cleared'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
