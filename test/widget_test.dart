import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:akscore/providers/matches_provider.dart';
import 'package:akscore/providers/theme_provider.dart';
import 'package:akscore/widgets/loading_shimmer.dart';
import 'package:akscore/screens/home_screen.dart';
import 'package:akscore/services/real_api_service.dart';
import 'widget_test.mocks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@GenerateMocks([MatchesProvider, ThemeProvider, RealApiService])
void main() {
  testWidgets('Show LoadingShimmer when loading', (WidgetTester tester) async {
    final mockMatchesProvider = MockMatchesProvider();
    final mockThemeProvider = MockThemeProvider();

    when(mockMatchesProvider.isLoading).thenReturn(true);
    when(mockMatchesProvider.liveMatches).thenReturn([]);
    when(mockMatchesProvider.todayMatches).thenReturn([]);
    when(mockMatchesProvider.favoriteMatches).thenReturn([]);
    when(mockMatchesProvider.error).thenReturn(null);
    when(mockMatchesProvider.hasListeners).thenReturn(false);

    when(mockThemeProvider.isDarkMode).thenReturn(false);
    when(mockThemeProvider.lightTheme).thenReturn(ThemeData.light());
    when(mockThemeProvider.darkTheme).thenReturn(ThemeData.dark());
    when(mockThemeProvider.hasListeners).thenReturn(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MatchesProvider>.value(
            value: mockMatchesProvider,
          ),
          ChangeNotifierProvider<ThemeProvider>.value(
            value: mockThemeProvider,
          ),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.byType(LoadingShimmer), findsOneWidget);
  });

  testWidgets('Show error message when there is an error', (WidgetTester tester) async {
    final mockMatchesProvider = MockMatchesProvider();
    final mockThemeProvider = MockThemeProvider();

    when(mockMatchesProvider.isLoading).thenReturn(false);
    when(mockMatchesProvider.liveMatches).thenReturn([]);
    when(mockMatchesProvider.todayMatches).thenReturn([]);
    when(mockMatchesProvider.favoriteMatches).thenReturn([]);
    when(mockMatchesProvider.error).thenReturn('An error occurred');
    when(mockMatchesProvider.hasListeners).thenReturn(false);

    when(mockThemeProvider.isDarkMode).thenReturn(false);
    when(mockThemeProvider.lightTheme).thenReturn(ThemeData.light());
    when(mockThemeProvider.darkTheme).thenReturn(ThemeData.dark());
    when(mockThemeProvider.hasListeners).thenReturn(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MatchesProvider>.value(
            value: mockMatchesProvider,
          ),
          ChangeNotifierProvider<ThemeProvider>.value(
            value: mockThemeProvider,
          ),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.text('An error occurred'), findsOneWidget);
    expect(find.text('Error loading matches'), findsOneWidget);
  });

  testWidgets('Show no matches message when there are no matches', (WidgetTester tester) async {
    final mockMatchesProvider = MockMatchesProvider();
    final mockThemeProvider = MockThemeProvider();

    when(mockMatchesProvider.isLoading).thenReturn(false);
    when(mockMatchesProvider.liveMatches).thenReturn([]);
    when(mockMatchesProvider.todayMatches).thenReturn([]);
    when(mockMatchesProvider.favoriteMatches).thenReturn([]);
    when(mockMatchesProvider.error).thenReturn(null);
    when(mockMatchesProvider.hasListeners).thenReturn(false);

    when(mockThemeProvider.isDarkMode).thenReturn(false);
    when(mockThemeProvider.lightTheme).thenReturn(ThemeData.light());
    when(mockThemeProvider.darkTheme).thenReturn(ThemeData.dark());
    when(mockThemeProvider.hasListeners).thenReturn(false);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MatchesProvider>.value(
            value: mockMatchesProvider,
          ),
          ChangeNotifierProvider<ThemeProvider>.value(
            value: mockThemeProvider,
          ),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.text('No live matches'), findsOneWidget);
    expect(find.text('Check back later for live action'), findsOneWidget);

    await tester.tap(find.byIcon(FontAwesomeIcons.calendarDay));
    await tester.pumpAndSettle();

    expect(find.text('No matches today'), findsOneWidget);
    expect(find.text('Check back tomorrow for more matches'), findsOneWidget);
  });
}
