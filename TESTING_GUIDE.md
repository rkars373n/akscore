# 🧪 AkScore Testing Guide

## Overview
This guide covers all testing strategies for the AkScore Flutter application, including unit tests, widget tests, integration tests, and performance tests.

## Test Structure

```
test/
├── unit/                          # Unit tests for business logic
│   ├── theme_provider_test.dart
│   ├── notification_service_test.dart
│   └── smart_reply_service_test.dart
├── widget/                        # Widget tests for UI components
│   ├── splash_screen_test.dart
│   └── login_screen_test.dart
├── integration/                   # Integration tests for app flow
│   └── app_flow_test.dart
├── performance/                   # Performance tests
│   └── performance_test.dart
├── test_runner.dart              # Test configuration and utilities
└── widget_test.dart             # Default widget test
```

## Running Tests

### 1. Run All Tests
```bash
flutter test
```

### 2. Run Specific Test Categories
```bash
# Unit tests only
flutter test test/unit/

# Widget tests only
flutter test test/widget/

# Integration tests only
flutter test test/integration/

# Performance tests only
flutter test test/performance/
```

### 3. Run Individual Test Files
```bash
# Run specific test file
flutter test test/unit/theme_provider_test.dart

# Run with verbose output
flutter test --verbose test/widget/splash_screen_test.dart
```

### 4. Run Tests with Coverage
```bash
# Generate coverage report
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Test Categories

### 🔧 Unit Tests
Test individual functions, methods, and classes in isolation.

**Files:**
- `theme_provider_test.dart` - Theme management logic
- `notification_service_test.dart` - Notification functionality
- `smart_reply_service_test.dart` - Smart reply features

**What to test:**
- Business logic functions
- Data validation
- Service methods
- Provider state changes

### 🎨 Widget Tests
Test individual widgets and UI components.

**Files:**
- `splash_screen_test.dart` - Splash screen UI
- `login_screen_test.dart` - Login form UI

**What to test:**
- Widget rendering
- User interactions
- Form validation
- UI state changes

### 🔄 Integration Tests
Test complete user flows and app navigation.

**Files:**
- `app_flow_test.dart` - Complete app flow

**What to test:**
- Navigation between screens
- Data flow between components
- End-to-end user scenarios

### ⚡ Performance Tests
Test app performance and responsiveness.

**Files:**
- `performance_test.dart` - Performance benchmarks

**What to test:**
- App startup time
- Animation performance
- Memory usage
- Response times

## Writing Tests

### Unit Test Example
```dart
test('should toggle theme correctly', () {
  final themeProvider = ThemeProvider();
  
  expect(themeProvider.isDarkMode, false);
  
  themeProvider.toggleTheme();
  expect(themeProvider.isDarkMode, true);
});
```

### Widget Test Example
```dart
testWidgets('should display login form', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
  
  expect(find.text('Welcome to AkScore'), findsOneWidget);
  expect(find.byType(TextFormField), findsNWidgets(2));
});
```

### Integration Test Example
```dart
testWidgets('should navigate from splash to home', (WidgetTester tester) async {
  await tester.pumpWidget(const AkScoreApp());
  await tester.pumpAndSettle();
  
  expect(find.byType(MaterialApp), findsOneWidget);
});
```

## Test Utilities

### TestUtils Class
The `TestUtils` class provides common test operations:

```dart
// Wait for animations
await TestUtils.waitForAnimations(tester);

// Wait for specific duration
await TestUtils.waitForDuration(tester, Duration(seconds: 2));

// Verify widget exists
TestUtils.verifyWidgetExists(find.text('Hello'));

// Verify multiple widgets
TestUtils.verifyMultipleWidgetsExist(find.byType(Text), 3);
```

## Best Practices

### 1. Test Naming
- Use descriptive test names
- Group related tests with `group()`
- Use `setUp()` and `tearDown()` for common operations

### 2. Test Organization
- Keep tests focused on single functionality
- Use meaningful assertions
- Test both positive and negative cases

### 3. Performance Considerations
- Use `pumpAndSettle()` for animations
- Avoid unnecessary `pump()` calls
- Test with realistic data

### 4. Mocking and Stubbing
- Mock external dependencies
- Use `Mockito` for complex mocking
- Stub network calls and file operations

## Continuous Integration

### GitHub Actions Example
```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v1
```

## Debugging Tests

### 1. Debug Individual Tests
```bash
flutter test --verbose test/unit/theme_provider_test.dart
```

### 2. Debug Widget Tests
```dart
testWidgets('debug test', (WidgetTester tester) async {
  await tester.pumpWidget(const MyWidget());
  
  // Add breakpoints here
  debugDumpApp(); // Print widget tree
  await tester.pumpAndSettle();
});
```

### 3. Debug Integration Tests
```bash
flutter test --verbose test/integration/
```

## Coverage Reports

### Generate Coverage
```bash
flutter test --coverage
```

### View Coverage
```bash
# Install lcov
brew install lcov  # macOS
sudo apt-get install lcov  # Ubuntu

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Test Data

### Sample Data
Create test data files in `test/data/`:
- `sample_matches.json`
- `sample_teams.json`
- `sample_players.json`

### Mock Services
Create mock services in `test/mocks/`:
- `mock_api_service.dart`
- `mock_notification_service.dart`

## Troubleshooting

### Common Issues

1. **Tests timing out**
   - Increase timeout: `testWidgets('test', (tester) async {}, timeout: Timeout(Duration(seconds: 30)))`

2. **Widget not found**
   - Use `pumpAndSettle()` to wait for animations
   - Check widget tree with `debugDumpApp()`

3. **Async operations**
   - Use `await` for async operations
   - Use `pump()` for state changes

4. **Platform-specific tests**
   - Use `Platform.isAndroid` for Android-specific tests
   - Use `Platform.isIOS` for iOS-specific tests

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Widget Testing Guide](https://docs.flutter.dev/cookbook/testing/widget)
- [Integration Testing](https://docs.flutter.dev/testing/integration-tests)
- [Mockito Package](https://pub.dev/packages/mockito)

Your AkScore app now has comprehensive test coverage! 🚀
