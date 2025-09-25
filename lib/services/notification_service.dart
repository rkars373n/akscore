import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
  }

  Future<void> _onNotificationTapped(NotificationResponse response) async {
    // Handle notification tap
  }

  NotificationDetails _getNotificationDetails(String channelId, String channelName, {String? channelDescription}) {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }

  Future<void> _showNotification(
    int id,
    String title,
    String body,
    NotificationDetails details, {
    String? payload,
  }) async {
    await _notifications.show(id, title, body, details, payload: payload);
  }

  Future<void> requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showGoalNotification({
    required String matchId,
    required String homeTeam,
    required String awayTeam,
    required String scorer,
    required int minute,
    required String team,
  }) async {
    final details = _getNotificationDetails(
      'goals',
      'Goal Notifications',
      channelDescription: 'Notifications for goals in your favorite matches',
    );
    await _showNotification(
      matchId.hashCode,
      'GOAL! $scorer',
      '$team scored in the $minute\' minute',
      details,
      payload: matchId,
    );
  }

  Future<void> showCardNotification({
    required String matchId,
    required String player,
    required String team,
    required int minute,
    required String cardType,
  }) async {
    final details = _getNotificationDetails(
      'cards',
      'Card Notifications',
      channelDescription: 'Notifications for cards in your favorite matches',
    );
await _showNotification(
      matchId.hashCode + 1,
      '$cardType CARD!',
      '$player ($minute\') for $team',
      details,
      payload: matchId,
    );
  }

  Future<void> showSubstitutionNotification({
    required String matchId,
    required String playerIn,
    required String playerOut,
    required String team,
    required int minute,
  }) async {
    final details = _getNotificationDetails(
      'substitutions',
      'Substitution Notifications',
      channelDescription: 'Notifications for substitutions in your favorite matches',
    );
    await _showNotification(
      matchId.hashCode + 2,
      'SUBSTITUTION!',
      '$playerOut → $playerIn ($minute\') for $team',
      details,
      payload: matchId,
    );
  }


  Future<void> showMatchStartNotification({
    required String matchId,
    required String homeTeam,
    required String awayTeam,
    required String league,
  }) async {
    final details = _getNotificationDetails(
      'match_start',
      'Match Start Notifications',
      channelDescription: 'Notifications when your favorite matches start',
    );
    await _showNotification(
      matchId.hashCode,
      'Match Started!',
      '$homeTeam vs $awayTeam in $league',
      details,
      payload: matchId,
    );
  }

  Future<void> showMatchEndNotification({
    required String matchId,
    required String homeTeam,
    required String awayTeam,
    required int homeScore,
    required int awayScore,
  }) async {
    final details = _getNotificationDetails(
      'match_end',
      'Match End Notifications',
      channelDescription: 'Notifications when your favorite matches end',
    );
    await _showNotification(
      matchId.hashCode,
      'Match Finished!',
      '$homeTeam $homeScore - $awayScore $awayTeam',
      details,
      payload: matchId,
    );
  }

  Future<void> scheduleMatchReminder({
    required String matchId,
    required String homeTeam,
    required String awayTeam,
    required DateTime matchTime,
    required int minutesBefore,
  }) async {
    final reminderTime = matchTime.subtract(Duration(minutes: minutesBefore));

    if (reminderTime.isBefore(DateTime.now())) return;

    final details = _getNotificationDetails(
      'match_reminders',
      'Match Reminders',
      channelDescription: 'Reminders for upcoming matches',
    );

    await _notifications.zonedSchedule(
      matchId.hashCode,
      'Match Starting Soon!',
      '$homeTeam vs $awayTeam starts in $minutesBefore minutes',
      tz.TZDateTime.from(reminderTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: matchId,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  Future<dynamic> getNotificationSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? false;
  }

  Future<void> setNotificationSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);

    if (!enabled) {
      await cancelAllNotifications();
    }
  }
}
