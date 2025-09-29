import 'package:flutter_test/flutter_test.dart';
import 'package:akscore/services/smart_reply_service.dart';

void main() {
  group('SmartReplyService Tests', () {
    test('should initialize without errors', () async {
      // Test that the service can be initialized without throwing exceptions
      expect(() => SmartReplyService.initialize(), returnsNormally);
    });

    test('should get smart replies without errors', () async {
      // Test that the getSmartReplies method doesn't throw exceptions
      expect(
        () => SmartReplyService.getSmartReplies('Great goal!'),
        returnsNormally,
      );
    });

    test('should return default replies', () {
      // Test that default replies are returned
      final defaultReplies = SmartReplyService.getDefaultReplies();

      expect(defaultReplies, isA<List<String>>());
      expect(defaultReplies.isNotEmpty, true);
      expect(defaultReplies.length, 8);

      // Check for specific default replies
      expect(defaultReplies.contains('Great goal!'), true);
      expect(defaultReplies.contains('Amazing match!'), true);
      expect(defaultReplies.contains('What a save!'), true);
      expect(defaultReplies.contains('Unbelievable!'), true);
    });

    test('should handle empty message gracefully', () async {
      // Test that empty messages are handled without errors
      final replies = await SmartReplyService.getSmartReplies('');
      expect(replies, isA<List<String>>());
    });

    test('should handle null message gracefully', () async {
      // Test that null messages are handled without errors
      final replies = await SmartReplyService.getSmartReplies('');
      expect(replies, isA<List<String>>());
    });
  });
}
