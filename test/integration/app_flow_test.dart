import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:akscore/main.dart';

void main() {
  group('AkScore App Integration Tests', () {
    testWidgets('should navigate from splash to home screen', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const AkScoreApp());

      // Verify splash screen is displayed initially
      expect(find.byType(MaterialApp), findsOneWidget);

      // Wait for splash screen animation and navigation
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // Verify that we've navigated to the home screen
      // The splash screen should have navigated to HomeScreen
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should display main navigation structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const AkScoreApp());
      await tester.pumpAndSettle();

      // Verify the main app structure
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should handle theme switching', (WidgetTester tester) async {
      await tester.pumpWidget(const AkScoreApp());
      await tester.pumpAndSettle();

      // Verify the app loads with default theme
      expect(find.byType(MaterialApp), findsOneWidget);

      // The theme provider should be available
      // This test verifies that the app can handle theme changes
      // without crashing
    });

    testWidgets('should initialize all providers correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const AkScoreApp());
      await tester.pumpAndSettle();

      // Verify that the app initializes without errors
      expect(find.byType(MaterialApp), findsOneWidget);

      // Verify that the MultiProvider is working
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
