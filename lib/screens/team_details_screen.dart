import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/team.dart';
import '../providers/teams_provider.dart';
import '../widgets/player_card.dart';

class TeamDetailsScreen extends StatefulWidget {
  final Team team;

  const TeamDetailsScreen({super.key, required this.team});

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadTeamDetails();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadTeamDetails() {
    final teamsProvider = Provider.of<TeamsProvider>(context, listen: false);
    teamsProvider.loadTeamDetails(widget.team.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team.shortName),
        actions: [
          Consumer<TeamsProvider>(
            builder: (context, teamsProvider, child) {
              return IconButton(
                icon: Icon(
                  teamsProvider.isFavorite(widget.team)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: teamsProvider.isFavorite(widget.team)
                      ? Colors.red
                      : null,
                ),
                onPressed: () {
                  if (teamsProvider.isFavorite(widget.team)) {
                    teamsProvider.removeFromFavorites(widget.team);
                  } else {
                    teamsProvider.addToFavorites(widget.team);
                  }
                },
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.info)),
            Tab(text: 'Players', icon: Icon(Icons.people)),
            Tab(text: 'Stats', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverview(),
          _buildPlayers(),
          _buildStatistics(),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTeamHeader(),
          const SizedBox(height: 24),
          _buildTeamInfo(),
          const SizedBox(height: 24),
          _buildVenueInfo(),
        ],
      ),
    );
  }

  Widget _buildTeamHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.team.crest),
              onBackgroundImageError: (exception, stackTrace) {},
              child: const Icon(Icons.sports_soccer, size: 50),
            ),
            const SizedBox(height: 16),
            Text(
              widget.team.name,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.team.shortName,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.team.tla,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Team Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Founded', '${widget.team.founded}'),
            _buildInfoRow('Club Colors', widget.team.clubColors),
            _buildInfoRow('Website', widget.team.website),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Venue Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Venue', widget.team.venue),
            _buildInfoRow('Address', widget.team.address),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayers() {
    if (widget.team.squad == null || widget.team.squad!.isEmpty) {
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
              'No players available',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Player information will be available soon',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.team.squad!.length,
      itemBuilder: (context, index) {
        final player = widget.team.squad![index];
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
  }

  Widget _buildStatistics() {
    if (widget.team.statistics == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No statistics available',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Statistics will be available soon',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildStatCard('Position', '${widget.team.statistics!.position}'),
          _buildStatCard('Played', '${widget.team.statistics!.played}'),
          _buildStatCard('Won', '${widget.team.statistics!.won}'),
          _buildStatCard('Drawn', '${widget.team.statistics!.drawn}'),
          _buildStatCard('Lost', '${widget.team.statistics!.lost}'),
          _buildStatCard('Goals For', '${widget.team.statistics!.goalsFor}'),
          _buildStatCard('Goals Against', '${widget.team.statistics!.goalsAgainst}'),
          _buildStatCard('Goal Difference', '${widget.team.statistics!.goalDifference}'),
          _buildStatCard('Points', '${widget.team.statistics!.points}'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

