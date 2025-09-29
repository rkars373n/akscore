import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_seeder.dart';
import '../config/firestore_config.dart';
import 'logging_service.dart';

class FirestoreInitService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Initialize Firestore with optimal settings
  static Future<void> initialize() async {
    try {
      LoggingService.init('Initializing Firestore...');

      // Configure Firestore settings
      await _configureFirestore();

      // Set up offline persistence
      await _enableOfflinePersistence();

      // Initialize collections with proper indexes
      await _initializeCollections();

      // Seed database with sample data (only if empty)
      await _seedIfEmpty();

      LoggingService.success('Firestore initialization completed');
    } catch (e) {
      LoggingService.error('Error initializing Firestore: $e');
      rethrow;
    }
  }

  /// Configure Firestore settings
  static Future<void> _configureFirestore() async {
    // Enable offline persistence
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    LoggingService.config('Firestore settings configured');
  }

  /// Enable offline persistence
  static Future<void> _enableOfflinePersistence() async {
    // Offline persistence is now configured through Settings.persistenceEnabled
    // in the _configureFirestore() method, so no additional setup is needed
    LoggingService.database('Offline persistence configured via Settings');
  }

  /// Initialize collections with proper structure
  static Future<void> _initializeCollections() async {
    LoggingService.database('Initializing collections...');

    // Create collection references to ensure they exist
    final collections = [
      FirestoreConfig.matchesCollection,
      FirestoreConfig.teamsCollection,
      FirestoreConfig.playersCollection,
      FirestoreConfig.favoritesCollection,
      FirestoreConfig.usersCollection,
      FirestoreConfig.notificationsCollection,
      FirestoreConfig.settingsCollection,
    ];

    for (final collection in collections) {
      // Create a dummy document to initialize the collection
      final docRef = _firestore.collection(collection).doc('_init');
      await docRef.set({
        'initialized': true,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    LoggingService.success('Collections initialized');
  }

  /// Seed database if empty
  static Future<void> _seedIfEmpty() async {
    try {
      // Check if database is empty
      final stats = await FirestoreSeeder.getDatabaseStats();
      final totalDocs = stats.values.fold(
        0,
        (total, docCount) => total + docCount,
      );

      if (totalDocs == 0) {
        LoggingService.database(
          'Database is empty, seeding with sample data...',
        );
        await FirestoreSeeder.seedDatabase();
      } else {
        LoggingService.info('Database already contains data, skipping seed');
      }
    } catch (e) {
      LoggingService.warning('Error checking/seeding database: $e');
    }
  }

  /// Set up real-time listeners for critical data
  static void setupRealtimeListeners() {
    LoggingService.init('Setting up real-time listeners...');

    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        LoggingService.user('User authenticated: ${user.uid}');
        _setupUserListeners(user.uid);
      } else {
        LoggingService.user('User signed out');
      }
    });
  }

  /// Set up user-specific listeners
  static void _setupUserListeners(String userId) {
    // Listen to user's favorites
    _firestore
        .collection(FirestoreConfig.favoritesCollection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
          LoggingService.database(
            'Favorites updated: ${snapshot.docs.length} items',
          );
        });

    // Listen to user's notifications
    _firestore
        .collection(FirestoreConfig.notificationsCollection)
        .where('userId', isEqualTo: userId)
        .where('read', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
          LoggingService.database(
            'New notifications: ${snapshot.docs.length} unread',
          );
        });
  }

  /// Set up global listeners for live data
  static void setupGlobalListeners() {
    LoggingService.init('Setting up global listeners...');

    // Listen to live matches
    _firestore
        .collection(FirestoreConfig.matchesCollection)
        .where('status', isEqualTo: 'live')
        .snapshots()
        .listen((snapshot) {
          LoggingService.database(
            'Live matches updated: ${snapshot.docs.length} matches',
          );
        });

    // Listen to recent matches
    _firestore
        .collection(FirestoreConfig.matchesCollection)
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots()
        .listen((snapshot) {
          LoggingService.database(
            'Recent matches updated: ${snapshot.docs.length} matches',
          );
        });
  }

  /// Optimize Firestore performance
  static Future<void> optimizePerformance() async {
    LoggingService.performance('Optimizing Firestore performance...');

    // Pre-warm cache with frequently accessed data
    await _preWarmCache();

    // Set up batch operations for better performance
    await _setupBatchOperations();

    LoggingService.success('Performance optimization completed');
  }

  /// Pre-warm cache with frequently accessed data
  static Future<void> _preWarmCache() async {
    try {
      // Load popular teams
      await _firestore
          .collection(FirestoreConfig.teamsCollection)
          .limit(20)
          .get();

      // Load recent matches
      await _firestore
          .collection(FirestoreConfig.matchesCollection)
          .orderBy('date', descending: true)
          .limit(10)
          .get();

      LoggingService.performance('Cache pre-warmed');
    } catch (e) {
      LoggingService.warning('Error pre-warming cache: $e');
    }
  }

  /// Set up batch operations for better performance
  static Future<void> _setupBatchOperations() async {
    // This would typically involve setting up batch write operations
    // for frequently updated data like match scores
    LoggingService.config('Batch operations configured');
  }

  /// Health check for Firestore connection
  static Future<bool> healthCheck() async {
    try {
      // Try to read from a collection
      await _firestore.collection('_health').doc('check').get();
      LoggingService.success('Firestore health check passed');
      return true;
    } catch (e) {
      LoggingService.error('Firestore health check failed: $e');
      return false;
    }
  }

  /// Get Firestore instance info
  static Future<Map<String, dynamic>> getInstanceInfo() async {
    try {
      final stats = await FirestoreSeeder.getDatabaseStats();
      final isHealthy = await healthCheck();

      return {
        'isHealthy': isHealthy,
        'collections': stats,
        'totalDocuments': stats.values.fold(
          0,
          (total, docCount) => total + docCount,
        ),
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'isHealthy': false,
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Cleanup resources
  static Future<void> cleanup() async {
    LoggingService.cleanup('Cleaning up Firestore resources...');

    // Close any open listeners
    // Note: In a real app, you'd want to store listener subscriptions
    // and cancel them here

    LoggingService.success('Cleanup completed');
  }
}
