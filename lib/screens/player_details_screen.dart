import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/player.dart';
import '../providers/players_provider.dart';

class PlayerDetailsScreen extends StatefulWidget {
  final Player player;

  const PlayerDetailsScreen({super.key, required this.player,});

  @override
  PlayerDetailsScreenState createState() => PlayerDetailsScreenState();
}

class PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await context.read<PlayersProvider>().isFavorite(widget.player.id);
    if (mounted) {
      setState(() {
        _isFavorite = isFavorite;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final playersProvider = context.read<PlayersProvider>();
    if (_isFavorite) {
      await playersProvider.removeFromFavorites(widget.player.id);
    } else {
      await playersProvider.addToFavorites(widget.player.id);
    }
    if (mounted) {
      setState(() {
        _isFavorite = !_isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star),
            color: _isFavorite ? Colors.amber : null,
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildPlayerInfo(),
            const SizedBox(height: 16),
            _buildPlayerStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Hero(
          tag: 'player-photo-${widget.player.id}',
          child: CachedNetworkImage(
            imageUrl: widget.player.photo,
            height: 150,
            width: 150,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.person, size: 150),
          ),
        ),
        const SizedBox(height: 16),
        Text(widget.player.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPlayerInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem('Number', widget.player.number.toString(), context),
            _buildInfoItem('Position', widget.player.position, context),
            _buildInfoItem('Age', widget.player.age.toString(), context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, BuildContext context) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPlayerStats() {
    final stats = widget.player.stats;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistics', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 16,
              children: [
                _buildStatItem('Matches Played', stats.matchesPlayed.toString(), context),
                _buildStatItem('Minutes Played', stats.minutesPlayed.toString(), context),
                _buildStatItem('Goals', stats.goals.toString(), context),
                _buildStatItem('Assists', stats.assists.toString(), context),
                _buildStatItem('Shots On Target', stats.shotsOnTarget.toString(), context),
                _buildStatItem('Shots Off Target', stats.shotsOffTarget.toString(), context),
                _buildStatItem('Passes Completed', stats.passesCompleted.toString(), context),
                _buildStatItem('Passes Missed', stats.passesMissed.toString(), context),
                _buildStatItem('Tackles', stats.tackles.toString(), context),
                _buildStatItem('Interceptions', stats.interceptions.toString(), context),
                _buildStatItem('Yellow Cards', stats.yellowCards.toString(), context),
                _buildStatItem('Red Cards', stats.redCards.toString(), context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
