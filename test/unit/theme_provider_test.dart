import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:akscore/providers/theme_provider.dart';

void main() {
  group('ThemeProvider Tests', () {
    late ThemeProvider themeProvider;

    setUp(() {
      themeProvider = ThemeProvider();
    });

    test('should initialize with light theme by default', () {
      expect(themeProvider.isDarkMode, false);
    });

    test('should toggle theme correctly', () {
      // Initial state
      expect(themeProvider.isDarkMode, false);

      // Toggle to dark
      themeProvider.toggleTheme();
      expect(themeProvider.isDarkMode, true);

      // Toggle back to light
      themeProvider.toggleTheme();
      expect(themeProvider.isDarkMode, false);
    });

    test('should set theme correctly', () {
      // Set to dark theme
      themeProvider.setTheme(true);
      expect(themeProvider.isDarkMode, true);

      // Set to light theme
      themeProvider.setTheme(false);
      expect(themeProvider.isDarkMode, false);
    });

    test('should return correct theme data', () {
      // Light theme
      final lightTheme = themeProvider.lightTheme;
      expect(lightTheme.brightness, Brightness.light);
      expect(lightTheme.primaryColor, Colors.blue);

      // Dark theme
      themeProvider.setTheme(true);
      final darkTheme = themeProvider.darkTheme;
      expect(darkTheme.brightness, Brightness.dark);
      expect(darkTheme.primaryColor, Colors.blue);
    });

    test('should return current theme based on mode', () {
      // Light mode
      expect(themeProvider.currentTheme.brightness, Brightness.light);

      // Dark mode
      themeProvider.setTheme(true);
      expect(themeProvider.currentTheme.brightness, Brightness.dark);
    });
  });
}
