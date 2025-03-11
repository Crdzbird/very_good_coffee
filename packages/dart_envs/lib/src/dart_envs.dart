/// Dart environment variables.
///
/// This library provides access to environment variables defined in the Dart
final class DartEnvs {
  factory DartEnvs() => _self;

  DartEnvs._internal();

  static final DartEnvs _self = DartEnvs._internal();

  /// The base URL for the application.
  String get baseUrl => const String.fromEnvironment('baseUrl');
}
