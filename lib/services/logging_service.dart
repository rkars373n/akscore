import 'package:logger/logger.dart';

/// Centralized logging service for the application
class LoggingService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// Log debug messages
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log info messages
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log warning messages
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log error messages
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log fatal messages
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Log success messages (custom level)
  static void success(String message) {
    _logger.i('✅ $message');
  }

  /// Log initialization messages (custom level)
  static void init(String message) {
    _logger.i('🚀 $message');
  }

  /// Log configuration messages (custom level)
  static void config(String message) {
    _logger.i('⚙️ $message');
  }

  /// Log database operations (custom level)
  static void database(String message) {
    _logger.i('🗄️ $message');
  }

  /// Log network operations (custom level)
  static void network(String message) {
    _logger.i('🌐 $message');
  }

  /// Log user operations (custom level)
  static void user(String message) {
    _logger.i('👤 $message');
  }

  /// Log security operations (custom level)
  static void security(String message) {
    _logger.i('🔒 $message');
  }

  /// Log performance metrics (custom level)
  static void performance(String message) {
    _logger.i('⚡ $message');
  }

  /// Log cleanup operations (custom level)
  static void cleanup(String message) {
    _logger.i('🧹 $message');
  }
}
