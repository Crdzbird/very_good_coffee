import 'package:flutter_test/flutter_test.dart';
import 'package:dart_envs/dart_envs.dart';

void main() {
  test('DartEnvs is a singleton', () {
    final instance1 = DartEnvs();
    final instance2 = DartEnvs();
    expect(instance1, same(instance2));
  });

  test('baseUrl returns the correct value from environment', () {
    final dartEnvs = DartEnvs();
    expect(dartEnvs.baseUrl, '');
  });
}
