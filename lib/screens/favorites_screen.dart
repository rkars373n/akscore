import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/matches_provider.dart';
import '../providers/teams_provider.dart';
import '../providers/players_provider.dart';
import '../widgets/match_card.dart';
import '../widgets/team_card.dart';
import '../widgets/player_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Favorites'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Matches', icon: Icon(Icons.sports_soccer)),
            Tab(text: 'Teams', icon: Icon(Icons.groups)),
            Tab(text: 'Players', icon: Icon(Icons.person)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFavoriteMatches(),
          _buildFavoriteTeams(),
          _buildFavoritePlayers(),
        ],
      ),
    );
  }

  Widget _buildFavoriteMatches() {
    return Consumer<MatchesProvider>(
      builder: (context, matchesProvider, child) {
        if (matchesProvider.favoriteMatches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorite matches',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add matches to your favorites to see them here',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: matchesProvider.favoriteMatches.length,
          itemBuilder: (context, index) {
            final match = matchesProvider.favoriteMatches[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MatchCard(
                match: match,
                onTap: () {
                  // Navigate to match details
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFavoriteTeams() {
    return Consumer<TeamsProvider>(
      builder: (context, teamsProvider, child) {
        if (teamsProvider.favoriteTeams.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorite teams',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add teams to your favorites to see them here',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: teamsProvider.favoriteTeams.length,
          itemBuilder: (context, index) {
            final team = teamsProvider.favoriteTeams[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TeamCard(
                team: team,
                onTap: () {
                  // Navigate to team details
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFavoritePlayers() {
    return Consumer<PlayersProvider>(
      builder: (context, playersProvider, child) {
        if (playersProvider.favoritePlayers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorite players',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add players to your favorites to see them here',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: playersProvider.favoritePlayers.length,
          itemBuilder: (context, index) {
            final player = playersProvider.favoritePlayers[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PlayerCard(
                player: player,
                onTap: () {
                  // Navigate to player details
                },
              ),
            );
          },
        );
      },
    );
  }
}

