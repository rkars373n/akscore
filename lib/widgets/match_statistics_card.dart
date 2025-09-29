import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchStatisticsCard extends StatelessWidget {
  final MatchStatistics statistics;

  const MatchStatisticsCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Match Statistics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...statistics.statistics.map((stat) => _buildStatRow(context, stat)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, Statistic stat) {
    final maxValue = [stat.home, stat.away].reduce((a, b) => a > b ? a : b);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stat.type,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${stat.home} - ${stat.away}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatBar(stat.home, maxValue, Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatBar(stat.away, maxValue, Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(int value, int maxValue, Color color) {
    final percentage = maxValue > 0 ? value / maxValue : 0.0;
    
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

