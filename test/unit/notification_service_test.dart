import 'package:flutter_test/flutter_test.dart';
import 'package:akscore/services/notification_service.dart';

void main() {
  group('NotificationService Tests', () {
    test('should initialize without errors', () async {
      // This test verifies that the service can be initialized
      // without throwing exceptions
      expect(() => NotificationService.initialize(), returnsNormally);
    });

    test('should show notification without errors', () async {
      // Test that the show method doesn't throw exceptions
      expect(
        () => NotificationService.show(
          1,
          'Test Title',
          'Test Body',
          'test_payload',
        ),
        returnsNormally,
      );
    });

    test('should schedule match reminder without errors', () async {
      // Test that the scheduleMatchReminder method doesn't throw exceptions
      final scheduledTime = DateTime.now().add(const Duration(hours: 1));

      expect(
        () => NotificationService.scheduleMatchReminder(
          1,
          'Match Reminder',
          'Your match is starting soon!',
          scheduledTime,
        ),
        returnsNormally,
      );
    });

    test('should cancel notification without errors', () async {
      // Test that the cancelNotification method doesn't throw exceptions
      expect(() => NotificationService.cancelNotification(1), returnsNormally);
    });

    test('should cancel all notifications without errors', () async {
      // Test that the cancelAllNotifications method doesn't throw exceptions
      expect(
        () => NotificationService.cancelAllNotifications(),
        returnsNormally,
      );
    });

    test('should get pending notifications without errors', () async {
      // Test that the getPendingNotifications method doesn't throw exceptions
      expect(
        () => NotificationService.getPendingNotifications(),
        returnsNormally,
      );
    });
  });
}
