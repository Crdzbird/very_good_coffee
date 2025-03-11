final class DartEnvs {
  factory DartEnvs() => _self;

  DartEnvs._internal();

  static final DartEnvs _self = DartEnvs._internal();

  String get baseUrl => const String.fromEnvironment('baseUrl');
}
