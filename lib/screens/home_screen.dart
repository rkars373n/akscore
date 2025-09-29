import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../providers/matches_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/match_card.dart';
import '../widgets/loading_shimmer.dart';
import 'match_details_screen.dart';

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
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadData() {
    final matchesProvider = Provider.of<MatchesProvider>(context, listen: false);
    matchesProvider.loadLiveMatches();
    matchesProvider.loadTodayMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AkScore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDateRange(context),
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Live', icon: Icon(Icons.live_tv)),
            Tab(text: 'Matches', icon: Icon(Icons.event)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLiveMatches(),
          _buildMatches(),
        ],
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final matchesProvider = Provider.of<MatchesProvider>(context, listen: false);
    final initialDateRange = matchesProvider.dateRange ??
        DateTimeRange(start: DateTime.now(), end: DateTime.now());

    final newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (newDateRange != null) {
      matchesProvider.loadMatchesForDateRange(newDateRange);
      _tabController.animateTo(1);
    }
  }

  Widget _buildLiveMatches() {
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
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${matchesProvider.error}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => matchesProvider.loadLiveMatches(),
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
                Icon(
                  Icons.sports_soccer,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No live matches',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Check back later for live action!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => matchesProvider.loadLiveMatches(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matchesProvider.liveMatches.length,
            itemBuilder: (context, index) {
              final match = matchesProvider.liveMatches[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MatchCard(
                  match: match,
                  onTap: () => _navigateToMatchDetails(match),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMatches() {
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
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${matchesProvider.error}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (matchesProvider.dateRange != null) {
                      matchesProvider.loadMatchesForDateRange(matchesProvider.dateRange!);
                    } else {
                      matchesProvider.loadTodayMatches();
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final matches = matchesProvider.dateRangeMatches.isNotEmpty
            ? matchesProvider.dateRangeMatches
            : matchesProvider.todayMatches;

        if (matches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_soccer,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  matchesProvider.dateRange != null
                      ? 'No matches in the selected range'
                      : 'No matches today',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  matchesProvider.dateRange != null
                      ? 'Try selecting a different date range'
                      : 'Check back tomorrow for more matches!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (matchesProvider.dateRange != null) {
              await matchesProvider.loadMatchesForDateRange(matchesProvider.dateRange!);
            } else {
              await matchesProvider.loadTodayMatches();
            }
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MatchCard(
                  match: match,
                  onTap: () => _navigateToMatchDetails(match),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToMatchDetails(Match match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailsScreen(match: match),
      ),
    );
  }
}
