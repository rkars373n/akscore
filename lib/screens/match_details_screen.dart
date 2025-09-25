import 'dart:async';
import 'package:akscore/models/team.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../services/real_api_service.dart';
import '../services/realtime_service.dart';
import '../providers/matches_provider.dart';
import '../widgets/chat_widget.dart';
import '../widgets/match_event_card.dart';
import '../widgets/match_statistics_card.dart';
import 'team_details_screen.dart';

class MatchDetailsScreen extends StatefulWidget {
  final String matchId;

  const MatchDetailsScreen({super.key, required this.matchId});

  @override
  MatchDetailsScreenState createState() => MatchDetailsScreenState();
}

class MatchDetailsScreenState extends State<MatchDetailsScreen> {
  Match? _match;
  bool _isLoading = true;
  String? _error;
  bool _isFavorite = false;
  final RealApiService _apiService = RealApiService();
  final RealtimeService _realtimeService = RealtimeService();
  StreamSubscription? _matchUpdateSubscription;

  @override
  void initState() {
    super.initState();
    _loadMatchDetails();
    _checkFavoriteStatus();
    _subscribeToMatchUpdates();
  }

  @override
  void dispose() {
    _matchUpdateSubscription?.cancel();
    _realtimeService.unsubscribeFromMatch(widget.matchId);
    super.dispose();
  }

  Future<void> _loadMatchDetails() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final match = await _apiService.getMatchDetails(widget.matchId);
      if (mounted) {
        setState(() {
          _match = match;
          _isLoading = false;
        });
        if (match.isLive) {
          _realtimeService.subscribeToMatch(widget.matchId);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _subscribeToMatchUpdates() {
    _matchUpdateSubscription = _realtimeService.matchUpdateStream
        .where((match) => match.id == widget.matchId)
        .listen((match) {
      if (mounted) {
        setState(() {
          _match = match;
        });
      }
    });
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await context.read<MatchesProvider>().isFavorite(widget.matchId);
    if (mounted) {
      setState(() {
        _isFavorite = isFavorite;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final matchesProvider = context.read<MatchesProvider>();
    if (_isFavorite) {
      await matchesProvider.removeFromFavorites(widget.matchId);
    } else {
      await matchesProvider.addToFavorites(widget.matchId);
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
        title: const Text('Match Details'),
        actions: [
          if (_match != null)
            IconButton(
              icon: Icon(_isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star, color: _isFavorite ? Colors.amber : null),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading match details:', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadMatchDetails,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    if (_match == null) {
      return const Center(child: Text('Match details not found.'));
    }
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildMatchHeader(),
                const SizedBox(height: 16),
                MatchStatisticsCard(statistics: _match!.statistics),
                const SizedBox(height: 16),
                _buildEvents(context),
              ],
            ),
          ),
        ),
        const Divider(height: 1.0),
        const Expanded(
          child: ChatWidget(),
        )
      ],
    );
  }

  Widget _buildMatchHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTeamDisplay(_match!.homeTeam.value),
        Column(
          children: [
            Text(
              _match!.status,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${_match!.goalsHome} - ${_match!.goalsAway}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (_match!.isLive && _match!.minute != null)
              Text(
                '${_match!.minute}\'',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green),
              ),
          ],
        ),
        _buildTeamDisplay(_match!.awayTeam.value),
      ],
    );
  }

  Widget _buildTeamDisplay(Team? team) {
    if (team == null) {
      return const SizedBox(width: 80, height: 110);
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamDetailsScreen(teamId: team.id),
          ),
        );
      },
      child: Column(
        children: [
          Image.network(team.logo, width: 80, height: 80, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error)),
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Text(
              team.name,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvents(BuildContext context) {
    if (_match!.events.isEmpty) {
      return const Center(child: Text('No events yet.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Match Events',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        ..._match!.events.map((event) => MatchEventCard(event: event)),
      ],
    );
  }
}
