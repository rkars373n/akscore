import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreConfig {
  // Collection names
  static const String matchesCollection = 'matches';
  static const String teamsCollection = 'teams';
  static const String playersCollection = 'players';
  static const String favoritesCollection = 'favorites';
  static const String usersCollection = 'users';
  static const String notificationsCollection = 'notifications';
  static const String settingsCollection = 'settings';

  // Index configurations for better query performance
  static const Map<String, List<String>> compositeIndexes = {
    'matches': [
      'status,date',
      'homeTeamId,date',
      'awayTeamId,date',
      'league,date',
      'status,league,date',
    ],
    'teams': ['league,name', 'country,name', 'league,country'],
    'players': ['teamId,name', 'position,name', 'teamId,position'],
    'favorites': ['userId,itemType', 'userId,createdAt', 'itemType,createdAt'],
    'users': ['email', 'createdAt', 'lastLoginAt'],
  };

  // Security rules template
  static const String securityRules = '''
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Users can read all matches
    match /matches/{matchId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        (resource == null || resource.data.createdBy == request.auth.uid);
    }
    
    // Users can read all teams
    match /teams/{teamId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Users can read all players
    match /players/{playerId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Users can manage their own favorites
    match /favorites/{favoriteId} {
      allow read, write: if request.auth != null && 
        (resource == null || resource.data.userId == request.auth.uid);
    }
    
    // Users can read notifications
    match /notifications/{notificationId} {
      allow read: if request.auth != null && 
        (resource == null || resource.data.userId == request.auth.uid);
      allow write: if request.auth != null;
    }
    
    // Users can read and write their own settings
    match /settings/{settingId} {
      allow read, write: if request.auth != null && 
        (resource == null || resource.data.userId == request.auth.uid);
    }
  }
}
''';

  // Field validation rules
  static const Map<String, Map<String, dynamic>> fieldValidation = {
    'matches': {
      'homeTeamId': {'type': 'string', 'required': true},
      'awayTeamId': {'type': 'string', 'required': true},
      'homeScore': {'type': 'number', 'required': false},
      'awayScore': {'type': 'number', 'required': false},
      'status': {
        'type': 'string',
        'required': true,
        'enum': ['scheduled', 'live', 'finished', 'postponed', 'cancelled'],
      },
      'date': {'type': 'timestamp', 'required': true},
      'league': {'type': 'string', 'required': true},
      'venue': {'type': 'string', 'required': false},
      'createdBy': {'type': 'string', 'required': true},
      'createdAt': {'type': 'timestamp', 'required': true},
      'updatedAt': {'type': 'timestamp', 'required': true},
    },
    'teams': {
      'name': {'type': 'string', 'required': true},
      'shortName': {'type': 'string', 'required': false},
      'logo': {'type': 'string', 'required': false},
      'country': {'type': 'string', 'required': true},
      'league': {'type': 'string', 'required': true},
      'founded': {'type': 'number', 'required': false},
      'stadium': {'type': 'string', 'required': false},
      'website': {'type': 'string', 'required': false},
      'createdAt': {'type': 'timestamp', 'required': true},
      'updatedAt': {'type': 'timestamp', 'required': true},
    },
    'players': {
      'name': {'type': 'string', 'required': true},
      'teamId': {'type': 'string', 'required': true},
      'position': {'type': 'string', 'required': true},
      'jerseyNumber': {'type': 'number', 'required': false},
      'age': {'type': 'number', 'required': false},
      'nationality': {'type': 'string', 'required': false},
      'height': {'type': 'number', 'required': false},
      'weight': {'type': 'number', 'required': false},
      'photo': {'type': 'string', 'required': false},
      'createdAt': {'type': 'timestamp', 'required': true},
      'updatedAt': {'type': 'timestamp', 'required': true},
    },
    'favorites': {
      'userId': {'type': 'string', 'required': true},
      'itemId': {'type': 'string', 'required': true},
      'itemType': {
        'type': 'string',
        'required': true,
        'enum': ['team', 'player', 'match'],
      },
      'createdAt': {'type': 'timestamp', 'required': true},
    },
    'users': {
      'email': {'type': 'string', 'required': true},
      'displayName': {'type': 'string', 'required': false},
      'photoURL': {'type': 'string', 'required': false},
      'favoriteTeams': {'type': 'array', 'required': false},
      'favoritePlayers': {'type': 'array', 'required': false},
      'notificationsEnabled': {
        'type': 'boolean',
        'required': false,
        'default': true,
      },
      'createdAt': {'type': 'timestamp', 'required': true},
      'lastLoginAt': {'type': 'timestamp', 'required': false},
    },
  };

  // Batch operation limits
  static const int maxBatchSize = 500;
  static const int maxQueryLimit = 1000;

  // Cache settings
  static const Duration cacheExpiration = Duration(minutes: 5);
  static const int maxCacheSize = 100;

  // Error messages
  static const Map<String, String> errorMessages = {
    'permission_denied': 'You do not have permission to perform this action',
    'not_found': 'The requested document was not found',
    'already_exists': 'A document with this ID already exists',
    'invalid_argument': 'Invalid argument provided',
    'deadline_exceeded': 'Request timeout. Please try again',
    'resource_exhausted': 'Too many requests. Please try again later',
    'unauthenticated': 'You must be logged in to perform this action',
    'unavailable': 'Service temporarily unavailable. Please try again later',
  };

  // Helper methods
  static String getErrorMessage(String errorCode) {
    return errorMessages[errorCode] ?? 'An unknown error occurred';
  }

  static bool isValidFieldValue(
    dynamic value,
    Map<String, dynamic> validation,
  ) {
    if (validation['required'] == true && value == null) {
      return false;
    }

    if (value == null) return true; // Optional field

    switch (validation['type']) {
      case 'string':
        return value is String;
      case 'number':
        return value is num;
      case 'boolean':
        return value is bool;
      case 'timestamp':
        return value is Timestamp;
      case 'array':
        return value is List;
      case 'enum':
        return validation['enum']?.contains(value) == true;
      default:
        return true;
    }
  }

  static Map<String, dynamic> getDefaultValues(String collection) {
    final now = Timestamp.now();
    switch (collection) {
      case 'matches':
        return {
          'status': 'scheduled',
          'homeScore': 0,
          'awayScore': 0,
          'createdAt': now,
          'updatedAt': now,
        };
      case 'teams':
        return {'createdAt': now, 'updatedAt': now};
      case 'players':
        return {'createdAt': now, 'updatedAt': now};
      case 'favorites':
        return {'createdAt': now};
      case 'users':
        return {'notificationsEnabled': true, 'createdAt': now};
      default:
        return {};
    }
  }
}
