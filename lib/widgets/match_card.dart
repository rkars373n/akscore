import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/match.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;

  const MatchCard({
    super.key,
    required this.match,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildMatchHeader(context),
              const SizedBox(height: 12),
              _buildMatchScore(context),
              if (match.isLive) ...[
                const SizedBox(height: 8),
                _buildLiveIndicator(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            match.competition,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getStatusText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchScore(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildTeamLogo(match.homeTeam.crest),
              const SizedBox(height: 8),
              Text(
                match.homeTeam.shortName,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          children: [
            Text(
              '${match.score.fullTime.home ?? 0} - ${match.score.fullTime.away ?? 0}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(match.utcDate),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              _buildTeamLogo(match.awayTeam.crest),
              const SizedBox(height: 8),
              Text(
                match.awayTeam.shortName,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamLogo(String crest) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: CachedNetworkImage(
        imageUrl: crest,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Icon(
          Icons.sports_soccer,
          color: Colors.grey,
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.sports_soccer,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildLiveIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'LIVE',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (match.status) {
      case 'IN_PLAY':
        return Colors.green;
      case 'PAUSED':
        return Colors.orange;
      case 'FINISHED':
        return Colors.blue;
      case 'SCHEDULED':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText() {
    switch (match.status) {
      case 'IN_PLAY':
        return 'LIVE';
      case 'PAUSED':
        return 'PAUSED';
      case 'FINISHED':
        return 'FINISHED';
      case 'SCHEDULED':
        return 'SCHEDULED';
      default:
        return match.status;
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

