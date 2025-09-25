import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchStatisticsCard extends StatelessWidget {
  final MatchStatistics statistics;

  const MatchStatisticsCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistics', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildStatisticRow(context, 'Shots', statistics.shotsHome, statistics.shotsAway),
            _buildStatisticRow(context, 'Shots on Target', statistics.shotsOnTargetHome, statistics.shotsOnTargetAway),
            _buildStatisticRow(context, 'Possession', statistics.possessionHome, statistics.possessionAway, isPercentage: true),
            _buildStatisticRow(context, 'Passes', statistics.passesHome, statistics.passesAway),
            _buildStatisticRow(context, 'Fouls', statistics.foulsHome, statistics.foulsAway),
            _buildStatisticRow(context, 'Yellow Cards', statistics.yellowCardsHome, statistics.yellowCardsAway),
            _buildStatisticRow(context, 'Red Cards', statistics.redCardsHome, statistics.redCardsAway),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticRow(BuildContext context, String title, int? homeValue, int? awayValue, {bool isPercentage = false}) {
    homeValue ??= 0;
    awayValue ??= 0;
    final total = homeValue + awayValue;
    final homePercentage = total > 0 ? homeValue / total : 0.5;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(isPercentage ? '$homeValue%' : homeValue.toString(), style: Theme.of(context).textTheme.bodyLarge),
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              Text(isPercentage ? '$awayValue%' : awayValue.toString(), style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                Expanded(
                  flex: (homePercentage * 100).toInt(),
                  child: Container(
                    height: 8,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  flex: ((1 - homePercentage) * 100).toInt(),
                  child: Container(
                    height: 8,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
