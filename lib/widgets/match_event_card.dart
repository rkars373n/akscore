import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/match.dart';

class MatchEventCard extends StatelessWidget {
  final MatchEvent event;

  const MatchEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            _buildEventIcon(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _buildEventTitle(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _buildEventDescription(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Text(
              '${event.minute}\'',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventIcon() {
    switch (event.type) {
      case MatchEventType.goal:
        return const FaIcon(FontAwesomeIcons.futbol, color: Colors.green, size: 24);
      case MatchEventType.yellowCard:
        return const FaIcon(FontAwesomeIcons.solidSquare, color: Colors.yellow, size: 20);
      case MatchEventType.redCard:
        return const FaIcon(FontAwesomeIcons.solidSquare, color: Colors.red, size: 20);
      case MatchEventType.substitution:
        return const FaIcon(FontAwesomeIcons.rightLeft, color: Colors.blue, size: 20);
      default:
        return const SizedBox.shrink();
    }
  }

  String _buildEventTitle() {
    switch (event.type) {
      case MatchEventType.goal:
        return 'Goal!';
      case MatchEventType.yellowCard:
        return 'Yellow Card';
      case MatchEventType.redCard:
        return 'Red Card';
      case MatchEventType.substitution:
        return 'Substitution';
      default:
        return 'Unknown Event';
    }
  }

  String _buildEventDescription() {
    switch (event.type) {
      case MatchEventType.goal:
        return '${event.player} scored for ${event.teamName}';
      case MatchEventType.yellowCard:
      case MatchEventType.redCard:
        return '${event.player} (${event.teamName})';
      case MatchEventType.substitution:
        return '${event.player} comes in for ${event.assist}';
      default:
        return '';
    }
  }
}
