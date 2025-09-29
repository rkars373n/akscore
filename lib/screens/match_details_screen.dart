import 'package:flutter/material.dart';
import '../models/match.dart';
import '../widgets/match_header.dart';

class MatchDetailsScreen extends StatelessWidget {
  final Match match;

  const MatchDetailsScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${match.homeTeam.shortName} vs ${match.awayTeam.shortName}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MatchHeader(match: match),
            // Add more match details widgets here
          ],
        ),
      ),
    );
  }
}
