import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchEventCard extends StatelessWidget {
  final MatchEvent event;

  const MatchEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildEventIcon(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.player,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (event.description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      event.description!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ],
              ),
            ),
            if (event.minute != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getEventColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${event.minute}\'',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEventIcon() {
    IconData iconData;
    Color iconColor;

    switch (event.type) {
      case 'GOAL':
        iconData = Icons.sports_soccer;
        iconColor = Colors.green;
        break;
      case 'YELLOW_CARD':
        iconData = Icons.sports;
        iconColor = Colors.yellow[700]!;
        break;
      case 'RED_CARD':
        iconData = Icons.sports;
        iconColor = Colors.red;
        break;
      case 'SUBSTITUTION':
        iconData = Icons.swap_horiz;
        iconColor = Colors.blue;
        break;
      default:
        iconData = Icons.info;
        iconColor = Colors.grey;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 18),
    );
  }

  Color _getEventColor() {
    switch (event.type) {
      case 'GOAL':
        return Colors.green;
      case 'YELLOW_CARD':
        return Colors.yellow[700]!;
      case 'RED_CARD':
        return Colors.red;
      case 'SUBSTITUTION':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
