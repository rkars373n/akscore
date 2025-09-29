import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:akscore/screens/login_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('should display login form with all elements', (
      WidgetTester tester,
    ) async {
      // Build the login screen
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Verify that the login screen loads
      expect(find.byType(LoginScreen), findsOneWidget);

      // Verify that the app icon is displayed
      expect(find.byIcon(Icons.sports_soccer), findsOneWidget);

      // Verify that the title is displayed
      expect(find.text('Welcome to AkScore'), findsOneWidget);

      // Verify that the subtitle is displayed
      expect(find.text('Sign in to get live football scores'), findsOneWidget);

      // Verify that the email field is displayed
      expect(find.byType(TextFormField), findsNWidgets(2));

      // Verify that the sign in button is displayed
      expect(find.text('Sign In'), findsOneWidget);

      // Verify that the forgot password link is displayed
      expect(find.text('Forgot Password?'), findsOneWidget);

      // Verify that the sign up link is displayed
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('should validate email field', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Find the email field
      final emailField = find.byType(TextFormField).first;

      // Test empty email validation
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter your email'), findsOneWidget);

      // Test invalid email validation
      await tester.enterText(emailField, 'invalid-email');
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter a valid email'), findsOneWidget);

      // Test valid email
      await tester.enterText(emailField, 'test@example.com');
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter your email'), findsNothing);
    });

    testWidgets('should validate password field', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Find the password field
      final passwordField = find.byType(TextFormField).at(1);

      // Test empty password validation
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter your password'), findsOneWidget);

      // Test short password validation
      await tester.enterText(passwordField, '123');
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(
        find.text('Password must be at least 6 characters'),
        findsOneWidget,
      );

      // Test valid password
      await tester.enterText(passwordField, 'password123');
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Please enter your password'), findsNothing);
    });

    testWidgets('should toggle password visibility', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Find the password visibility toggle button
      final visibilityButton = find.byType(IconButton).last;

      // Initially password should be obscured (test by checking the icon)
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);

      // Tap to show password
      await tester.tap(visibilityButton);
      await tester.pump();

      // Password should now be visible (test by checking the icon changed)
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsNothing);
    });

    testWidgets('should handle forgot password tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Tap forgot password
      await tester.tap(find.text('Forgot Password?'));
      await tester.pump();

      // Verify snackbar is shown
      expect(find.text('Forgot password feature coming soon'), findsOneWidget);
    });

    testWidgets('should handle sign up tap', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Tap sign up
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Verify snackbar is shown
      expect(find.text('Sign up feature coming soon'), findsOneWidget);
    });
  });
}
