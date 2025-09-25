import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/match.dart';
import '../services/favorites_service.dart';

class MatchCard extends StatefulWidget {
  final Match match;
  final VoidCallback? onTap;

  const MatchCard({super.key, required this.match, this.onTap,});

  @override
  MatchCardState createState() => MatchCardState();
}

class MatchCardState extends State<MatchCard> {
  final FavoritesService _favoritesService = FavoritesService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await _favoritesService.isFavorite(widget.match.id, 'match');
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await _favoritesService.removeFavorite(widget.match.id, 'match');
    } else {
      await _favoritesService.addFavorite(widget.match.id, 'match');
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLeagueHeader(context),
              const SizedBox(height: 12),
              _buildMatchInfo(context),
              const SizedBox(height: 12),
              _buildScoreSection(context),
              if (widget.match.isLive) ...[
                const SizedBox(height: 8),
                _buildLiveIndicator(context),
              ],
              const SizedBox(height: 8),
              _buildFavoriteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeagueHeader(BuildContext context) {
    return Row(
      children: [
        if (widget.match.leagueLogo.isNotEmpty)
          CachedNetworkImage(
            imageUrl: widget.match.leagueLogo,
            width: 20,
            height: 20,
            placeholder: (context, url) => Container(
              width: 20,
              height: 20,
              color: Colors.grey[300],
            ),
            errorWidget: (context, url, error) => Container(
              width: 20,
              height: 20,
              color: Colors.grey[300],
            ),
          ),
        if (widget.match.leagueLogo.isNotEmpty) const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.match.league,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          _formatMatchTime(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildMatchInfo(BuildContext context) {
    final homeTeam = widget.match.homeTeam.value;
    final awayTeam = widget.match.awayTeam.value;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              _buildTeamLogo(homeTeam?.logo ?? ''),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  homeTeam?.name ?? 'TBD',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  awayTeam?.name ?? 'TBD',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _buildTeamLogo(awayTeam?.logo ?? ''),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.match.goalsHome.toString(),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: widget.match.isLive ? Colors.red : null,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            _getStatusText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.match.goalsAway.toString(),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: widget.match.isLive ? Colors.red : null,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            _isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: _isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: _toggleFavorite,
        ),
      ],
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
          'LIVE ${widget.match.minute}\'',
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamLogo(String logoUrl) {
    if (logoUrl.isEmpty) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.futbol,
          size: 16,
          color: Colors.grey[600],
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: logoUrl,
      width: 32,
      height: 32,
      placeholder: (context, url) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.futbol,
          size: 16,
          color: Colors.grey[600],
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          FontAwesomeIcons.futbol,
          size: 16,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  String _formatMatchTime() {
    if (widget.match.isLive) {
      return 'LIVE';
    }
    
    final now = DateTime.now();
    final matchTime = widget.match.matchTime;
    final difference = matchTime.difference(now);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Now';
    }
  }

  Color _getStatusColor() {
    switch (widget.match.status.toLowerCase()) {
      case 'live':
        return Colors.red;
      case 'finished':
        return Colors.green;
      case 'scheduled':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText() {
    switch (widget.match.status.toLowerCase()) {
      case 'live':
        return 'LIVE';
      case 'finished':
        return 'FT';
      case 'scheduled':
        return 'VS';
      default:
        return widget.match.status.toUpperCase();
    }
  }
}
