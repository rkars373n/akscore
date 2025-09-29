import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class SmartReplyService {
  static const MethodChannel _channel = MethodChannel('smart_reply');
  static final Logger _logger = Logger();

  static Future<List<String>> getSmartReplies(String message) async {
    try {
      if (Platform.isAndroid) {
        final List<dynamic> replies = await _channel.invokeMethod(
          'getSmartReplies',
          {'message': message},
        );
        return replies.cast<String>();
      }
      return [];
    } catch (e) {
      _logger.e('Error getting smart replies: $e');
      return [];
    }
  }

  static Future<void> initialize() async {
    try {
      if (Platform.isAndroid) {
        await _channel.invokeMethod('initialize');
      }
    } catch (e) {
      _logger.e('Error initializing smart reply service: $e');
    }
  }

  static List<String> getDefaultReplies() {
    return [
      'Great goal!',
      'Amazing match!',
      'What a save!',
      'Unbelievable!',
      'Nice play!',
      'Well done!',
      'Fantastic!',
      'Incredible!',
    ];
  }
}
