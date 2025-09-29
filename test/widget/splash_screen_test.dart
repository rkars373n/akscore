import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:akscore/screens/splash_screen.dart';

void main() {
  group('SplashScreen Widget Tests', () {
    testWidgets('should display splash screen with correct elements', (
      WidgetTester tester,
    ) async {
      // Build the splash screen
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

      // Verify that the splash screen loads
      expect(find.byType(SplashScreen), findsOneWidget);

      // Verify that the app icon is displayed
      expect(find.byIcon(Icons.sports_soccer), findsOneWidget);

      // Verify that the app title is displayed
      expect(find.text('AkScore'), findsOneWidget);

      // Verify that the subtitle is displayed
      expect(find.text('Live Football Scores'), findsOneWidget);

      // Verify that the loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should have proper layout structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

      // Verify the main container exists
      expect(find.byType(Container), findsWidgets);

      // Verify the gradient decoration
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.decoration, isA<BoxDecoration>());

      // Verify the column layout
      expect(find.byType(Column), findsOneWidget);

      // Verify the animated builder
      expect(find.byType(AnimatedBuilder), findsOneWidget);
    });

    testWidgets('should display loading indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

      // Verify loading indicator is present
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Verify loading indicator has correct color
      final loadingIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(loadingIndicator.valueColor, isA<AlwaysStoppedAnimation<Color>>());
    });
  });
}
