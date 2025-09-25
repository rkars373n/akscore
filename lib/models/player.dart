import 'package:isar/isar.dart';
import '../utils/json_utils.dart';
import './team.dart';

part 'player.g.dart';

@collection
class Player {
  Id dbId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;
  late String name;
  late String position;
  late String nationality;
  late int age;
  late String photo;
  late int number;
  
  final stats = PlayerStats();

  // This is the forward link to the Team.
  final team = IsarLink<Team>();

  Player();

  factory Player.fromJson(Map<String, dynamic> json) {
    int calculateAge(String? dateOfBirth) {
      if (dateOfBirth == null) return 0;
      try {
        final birthDate = DateTime.parse(dateOfBirth);
        final today = DateTime.now();
        var age = today.year - birthDate.year;
        if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
          age--;
        }
        return age;
      } catch (e) {
        return 0;
      }
    }

    final playerInfo = json.containsKey('player') ? json['player'] : json;
    final statsJson = json.containsKey('statistics') ? json['statistics'][0] : {};
    
    final player = Player()
      ..id = playerInfo['id']?.toString() ?? ''
      ..name = playerInfo['name'] ?? ''
      ..position = playerInfo['position'] ?? statsJson['games']?['position'] ?? 'N/A'
      ..nationality = playerInfo['nationality'] ?? ''
      ..age = safeGetInt(playerInfo, ['age'], defaultValue: calculateAge(playerInfo['dateOfBirth']))
      ..photo = playerInfo['photo'] ?? ''
      ..number = safeGetInt(playerInfo, ['number'], defaultValue: safeGetInt(statsJson, ['games', 'number']));
      
    player.stats.fromJson(statsJson);
    return player;
  }
}

@embedded
class PlayerStats {
  int? matchesPlayed;
  int? goals;
  int? assists;
  int? yellowCards;
  int? redCards;
  int? minutesPlayed;
  int? shotsOnTarget;
  int? shotsOffTarget;
  int? passesCompleted;
  int? passesMissed;
  int? tackles;
  int? interceptions;

  PlayerStats();

  void fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return;
    }
    
    final totalPasses = safeGetInt(json, ['passes', 'total']);
    final dynamic passAccuracyValue = json['passes']?['accuracy'];
    final num passAccuracy = num.tryParse(passAccuracyValue?.toString() ?? '0') ?? 0;
    final completedPasses = (totalPasses * passAccuracy / 100).round();
    final shotsTotal = safeGetInt(json, ['shots', 'total']);
    final shotsOn = safeGetInt(json, ['shots', 'on']);
    final redCardsValue = safeGetInt(json, ['cards', 'red']) + safeGetInt(json, ['cards', 'yellowred']);

    matchesPlayed = safeGetInt(json, ['games', 'appearances']);
    goals = safeGetInt(json, ['goals', 'total']);
    assists = safeGetInt(json, ['goals', 'assists']);
    yellowCards = safeGetInt(json, ['cards', 'yellow']);
    redCards = redCardsValue;
    minutesPlayed = safeGetInt(json, ['games', 'minutes']);
    shotsOnTarget = shotsOn;
    shotsOffTarget = shotsTotal - shotsOn;
    passesCompleted = completedPasses;
    passesMissed = totalPasses - completedPasses;
    tackles = safeGetInt(json, ['tackles', 'total']);
    interceptions = safeGetInt(json, ['tackles', 'interceptions']);
  }
}
