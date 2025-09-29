import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/player.dart';
import '../providers/players_provider.dart';

class PlayerDetailsScreen extends StatefulWidget {
  final Player player;

  const PlayerDetailsScreen({super.key, required this.player});

  @override
  State<PlayerDetailsScreen> createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPlayerDetails();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadPlayerDetails() {
    final playersProvider = Provider.of<PlayersProvider>(
      context,
      listen: false,
    );
    playersProvider.loadPlayerDetails(widget.player.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name),
        actions: [
          Consumer<PlayersProvider>(
            builder: (context, playersProvider, child) {
              return IconButton(
                icon: Icon(
                  playersProvider.isFavorite(widget.player)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: playersProvider.isFavorite(widget.player)
                      ? Colors.red
                      : null,
                ),
                onPressed: () {
                  if (playersProvider.isFavorite(widget.player)) {
                    playersProvider.removeFromFavorites(widget.player);
                  } else {
                    playersProvider.addToFavorites(widget.player);
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
            Tab(text: 'Stats', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildOverview(), _buildStatistics()],
      ),
    );
  }

  Widget _buildOverview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPlayerHeader(),
          const SizedBox(height: 24),
          _buildPlayerInfo(),
          const SizedBox(height: 24),
          _buildPersonalInfo(),
        ],
      ),
    );
  }

  Widget _buildPlayerHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              child: Text(
                widget.player.name.split(' ').map((e) => e[0]).join(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.player.name,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.player.position,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (widget.player.shirtNumber != null) ...[
              const SizedBox(height: 8),
              Text(
                '#${widget.player.shirtNumber}',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Player Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Position', widget.player.position),
            _buildInfoRow('Nationality', widget.player.nationality),
            _buildInfoRow('Age', '${widget.player.age} years'),
            _buildInfoRow(
              'Date of Birth',
              _formatDate(widget.player.dateOfBirth),
            ),
            if (widget.player.role != null)
              _buildInfoRow('Role', widget.player.role!),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Full Name', widget.player.name),
            _buildInfoRow('Nationality', widget.player.nationality),
            _buildInfoRow(
              'Date of Birth',
              _formatDate(widget.player.dateOfBirth),
            ),
            _buildInfoRow('Age', '${widget.player.age} years'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    if (widget.player.statistics == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 64, color: Colors.grey[400]),
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
          _buildStatCard('Competition', widget.player.statistics!.competition),
          _buildStatCard('Season', widget.player.statistics!.season),
          _buildStatCard(
            'Appearances',
            '${widget.player.statistics!.appearances}',
          ),
          _buildStatCard('Goals', '${widget.player.statistics!.goals}'),
          _buildStatCard('Assists', '${widget.player.statistics!.assists}'),
          _buildStatCard(
            'Yellow Cards',
            '${widget.player.statistics!.yellowCards}',
          ),
          _buildStatCard('Red Cards', '${widget.player.statistics!.redCards}'),
          _buildStatCard(
            'Minutes Played',
            '${widget.player.statistics!.minutesPlayed}',
          ),
          _buildStatCard(
            'Rating',
            widget.player.statistics!.rating.toStringAsFixed(1),
          ),
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
            width: 120,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
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
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
