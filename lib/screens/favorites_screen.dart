import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/matches_provider.dart';
import '../providers/teams_provider.dart';
import '../providers/players_provider.dart';
import '../widgets/match_card.dart';
import '../widgets/team_card.dart';
import '../widgets/player_card.dart';
import 'match_details_screen.dart';
import 'team_details_screen.dart';
import 'player_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    // Use a post-frame callback to ensure the providers are available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<MatchesProvider>().fetchFavoriteMatches();
        context.read<TeamsProvider>().fetchFavoriteTeams();
        context.read<PlayersProvider>().fetchFavoritePlayers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Matches'),
            Tab(text: 'Teams'),
            Tab(text: 'Players'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFavoriteMatchesList(),
          _buildFavoriteTeamsList(),
          _buildFavoritePlayersList(),
        ],
      ),
    );
  }

  Widget _buildFavoriteMatchesList() {
    return Consumer<MatchesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }
        if (provider.favoriteMatches.isEmpty) {
          return const Center(child: Text('No favorite matches yet.'));
        }
        return ListView.builder(
          itemCount: provider.favoriteMatches.length,
          itemBuilder: (context, index) {
            final match = provider.favoriteMatches[index];
            return MatchCard(
              match: match,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatchDetailsScreen(matchId: match.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFavoriteTeamsList() {
    return Consumer<TeamsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }
        if (provider.favoriteTeams.isEmpty) {
          return const Center(child: Text('No favorite teams yet.'));
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: provider.favoriteTeams.length,
          itemBuilder: (context, index) {
            final team = provider.favoriteTeams[index];
            return TeamCard(
              team: team,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamDetailsScreen(teamId: team.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFavoritePlayersList() {
    return Consumer<PlayersProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }
        if (provider.favoritePlayers.isEmpty) {
          return const Center(child: Text('No favorite players yet.'));
        }
        return ListView.builder(
          itemCount: provider.favoritePlayers.length,
          itemBuilder: (context, index) {
            final player = provider.favoritePlayers[index];
            return PlayerCard(
              player: player,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerDetailsScreen(player: player),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
