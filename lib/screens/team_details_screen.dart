import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/team.dart';
import '../models/player.dart';
import '../services/real_api_service.dart';
import '../providers/teams_provider.dart';
import 'player_details_screen.dart';

class TeamDetailsScreen extends StatefulWidget {
  final String teamId;

  const TeamDetailsScreen({super.key, required this.teamId});

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  Team? _team;
  bool _isLoading = true;
  String? _error;
  bool _isFavorite = false;
  final RealApiService _apiService = RealApiService();

  @override
  void initState() {
    super.initState();
    _loadTeamDetails();
    _checkFavoriteStatus();
  }

  Future<void> _loadTeamDetails() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final team = await _apiService.getTeamDetails(widget.teamId);
      setState(() {
        _team = team;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await context.read<TeamsProvider>().isFavorite(widget.teamId);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    final teamsProvider = context.read<TeamsProvider>();
    if (_isFavorite) {
      await teamsProvider.removeFromFavorites(widget.teamId);
    } else {
      await teamsProvider.addToFavorites(widget.teamId);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details'),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart, color: _isFavorite ? Colors.red : null),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
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
              'Error loading team details',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadTeamDetails,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_team == null) {
      return Center(
        child: Text(
          'Team not found',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTeamHeader(),
          _buildTeamInfo(),
          _buildTeamStats(),
          _buildPlayersSection(),
        ],
      ),
    );
  }

  Widget _buildTeamHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withAlpha((255 * 0.8).round()),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: _team!.logo,
            width: 100,
            height: 100,
            placeholder: (context, url) => Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((255 * 0.3).round()),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FontAwesomeIcons.futbol,
                color: Colors.white,
                size: 50,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((255 * 0.3).round()),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FontAwesomeIcons.futbol,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _team!.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _team!.country,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Team Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('League', _team!.league),
            _buildInfoRow('Founded', _team!.founded.toString()),
            _buildInfoRow('Stadium', _team!.stadium),
            _buildInfoRow('Capacity', '${_team!.capacity.toString()} seats'),
            _buildInfoRow('Coach', _team!.coach),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamStats() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Season Statistics',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Matches', _team!.stats.matchesPlayed.toString()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard('Wins', _team!.stats.wins.toString()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard('Draws', _team!.stats.draws.toString()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard('Losses', _team!.stats.losses.toString()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Goals For', _team!.stats.goalsFor.toString()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard('Goals Against', _team!.stats.goalsAgainst.toString()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard('Points', _team!.stats.points.toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersSection() {
    if (_team!.players.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  FontAwesomeIcons.users,
                  size: 48,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No players available',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Players',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ..._team!.players.map((player) => _buildPlayerItem(player)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerItem(Player player) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerDetailsScreen(player: player),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: player.photo,
              width: 50,
              height: 50,
              placeholder: (context, url) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.grey[600],
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${player.position} • #${player.number}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${player.age} years',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  player.nationality,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
}
