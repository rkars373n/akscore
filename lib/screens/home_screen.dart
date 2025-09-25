import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/matches_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/match_card.dart';
import '../widgets/loading_shimmer.dart';
import 'match_details_screen.dart';
import 'settings_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MatchesProvider>().fetchLiveMatches();
      context.read<MatchesProvider>().fetchTodayMatches();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveScore'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.heart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode 
                    ? FontAwesomeIcons.sun 
                    : FontAwesomeIcons.moon,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.gear),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(FontAwesomeIcons.signal),
              text: 'Live',
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.calendarDay),
              text: 'Today',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLiveMatchesTab(),
          _buildTodayMatchesTab(),
        ],
      ),
    );
  }

  Widget _buildLiveMatchesTab() {
    return Consumer<MatchesProvider>(
      builder: (context, matchesProvider, child) {
        if (matchesProvider.isLoading) {
          return const LoadingShimmer();
        }

        if (matchesProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.triangleExclamation,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading matches',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  matchesProvider.error!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    matchesProvider.clearError();
                    matchesProvider.fetchLiveMatches();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (matchesProvider.liveMatches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.futbol,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No live matches',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Check back later for live action',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => matchesProvider.fetchLiveMatches(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matchesProvider.liveMatches.length,
            itemBuilder: (context, index) {
              final match = matchesProvider.liveMatches[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MatchCard(
                  match: match,
                  onTap: () => _navigateToMatchDetails(match.id),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTodayMatchesTab() {
    return Consumer<MatchesProvider>(
      builder: (context, matchesProvider, child) {
        if (matchesProvider.isLoading) {
          return const LoadingShimmer();
        }

        if (matchesProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.triangleExclamation,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading matches',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  matchesProvider.error!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    matchesProvider.clearError();
                    matchesProvider.fetchTodayMatches();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (matchesProvider.todayMatches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.calendarDay,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No matches today',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Check back tomorrow for more matches',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => matchesProvider.fetchTodayMatches(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matchesProvider.todayMatches.length,
            itemBuilder: (context, index) {
              final match = matchesProvider.todayMatches[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MatchCard(
                  match: match,
                  onTap: () => _navigateToMatchDetails(match.id),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToMatchDetails(String matchId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsScreen(matchId: matchId),
      ),
    );
  }
}
