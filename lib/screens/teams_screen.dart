
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/team.dart';
import '../providers/teams_provider.dart';
import '../widgets/team_card.dart';
import '../widgets/loading_shimmer.dart';
import 'team_details_screen.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final teamsProvider = Provider.of<TeamsProvider>(context, listen: false);
    teamsProvider.loadTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTeams(),
    );
  }

  Widget _buildTeams() {
    return Consumer<TeamsProvider>(
      builder: (context, teamsProvider, child) {
        if (teamsProvider.isLoading) {
          return const LoadingShimmer();
        }

        if (teamsProvider.error != null) {
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
                  'Error: ${teamsProvider.error}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => teamsProvider.loadTeams(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (teamsProvider.teams.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No teams found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Check back later for more teams!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => teamsProvider.loadTeams(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: teamsProvider.teams.length,
            itemBuilder: (context, index) {
              final team = teamsProvider.teams[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TeamCard(
                  team: team,
                  onTap: () => _navigateToTeamDetails(team),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToTeamDetails(Team team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsScreen(team: team),
      ),
    );
  }
}
