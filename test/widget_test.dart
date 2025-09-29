// This is a basic Flutter widget test for AkScore app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:akscore/main.dart';

void main() {
  testWidgets('AkScore app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AkScoreApp());

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);

    // Wait for the splash screen to load
    await tester.pumpAndSettle();

    // The app should show the splash screen initially
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
