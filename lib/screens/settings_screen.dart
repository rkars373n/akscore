import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Appearance'),
          _buildThemeToggle(),
          const SizedBox(height: 24),
          _buildSectionHeader('Notifications'),
          _buildNotificationSettings(),
          const SizedBox(height: 24),
          _buildSectionHeader('Data'),
          _buildDataSettings(context),
          const SizedBox(height: 24),
          _buildSectionHeader('About'),
          _buildAboutSettings(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          child: SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle between light and dark theme'),
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.setTheme(value),
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Match Notifications'),
            subtitle: const Text('Get notified about match events'),
            value: true,
            onChanged: (value) {
              // Handle notification toggle
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('Goal Notifications'),
            subtitle: const Text('Get notified when goals are scored'),
            value: true,
            onChanged: (value) {
              // Handle goal notification toggle
            },
            secondary: const Icon(Icons.sports_soccer),
          ),
          SwitchListTile(
            title: const Text('Match Reminders'),
            subtitle: const Text('Get reminded before matches start'),
            value: false,
            onChanged: (value) {
              // Handle reminder toggle
            },
            secondary: const Icon(Icons.schedule),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSettings(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: const Text('Clear Cache'),
            subtitle: const Text('Clear cached data to free up space'),
            leading: const Icon(Icons.storage),
            onTap: () {
              _showClearCacheDialog(context);
            },
          ),
          ListTile(
            title: const Text('Clear Favorites'),
            subtitle: const Text('Remove all favorite matches, teams, and players'),
            leading: const Icon(Icons.favorite_border),
            onTap: () {
              _showClearFavoritesDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
            leading: const Icon(Icons.info),
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            subtitle: const Text('View our privacy policy'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            subtitle: const Text('View our terms of service'),
            leading: const Icon(Icons.description),
            onTap: () {
              // Navigate to terms of service
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            subtitle: const Text('Get in touch with us'),
            leading: const Icon(Icons.contact_support),
            onTap: () {
              // Navigate to contact form
            },
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Are you sure you want to clear all cached data? This will free up space but may slow down the app temporarily.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Clear cache logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showClearFavoritesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Favorites'),
        content: const Text('Are you sure you want to remove all your favorite matches, teams, and players? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Clear favorites logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favorites cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

