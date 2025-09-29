import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/match.dart';
import '../models/team.dart';
import 'team_logo.dart';

class MatchHeader extends StatelessWidget {
  final Match match;

  const MatchHeader({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTeamRow(context),
          const SizedBox(height: 16.0),
          _buildScoreRow(context),
          const SizedBox(height: 8.0),
          _buildMatchStatus(context),
        ],
      ),
    );
  }

  Widget _buildTeamRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTeamDisplay(match.homeTeam, context),
        Text(
          'VS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(178),
          ),
        ),
        _buildTeamDisplay(match.awayTeam, context),
      ],
    );
  }

  Widget _buildTeamDisplay(Team team, BuildContext context) {
    return Column(
      children: [
        TeamLogo(logoUrl: team.crest, size: 60),
        const SizedBox(height: 8.0),
        Text(
          team.shortName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildScoreRow(BuildContext context) {
    final score = match.score;
    if (score.fullTime.home == null || score.fullTime.away == null) {
      return const SizedBox.shrink();
    }
    return Text(
      '${score.fullTime.home} - ${score.fullTime.away}',
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildMatchStatus(BuildContext context) {
    return Column(
      children: [
        Text(
          match.status.toUpperCase(),
          style: TextStyle(
            color: _getStatusColor(match.status, context),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          DateFormat.yMMMd().add_jm().format(match.utcDate.toLocal()),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Color _getStatusColor(String status, BuildContext context) {
    switch (status) {
      case 'IN_PLAY':
      case 'PAUSED':
        return Colors.green;
      case 'FINISHED':
        return Theme.of(context).colorScheme.primary;
      case 'SCHEDULED':
      case 'TIMED':
        return Colors.orange;
      case 'POSTPONED':
      case 'CANCELLED':
      case 'SUSPENDED':
        return Colors.red;
      default:
        return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    }
  }
}
