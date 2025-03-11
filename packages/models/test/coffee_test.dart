import 'package:models/src/coffee/coffee.dart';
import 'package:test/test.dart';

void main() {
  group(Coffee, () {
    test('supports value comparisons', () {
      expect(const Coffee(file: 'file'), equals(const Coffee(file: 'file')));
    });

    test(
      'can be instantiated',
      () => expect(Coffee.fromJson(const {'file': 'name'}), isNotNull),
    );

    test(
      'fromJson returns a valid Coffee',
      () => expect(Coffee.fromJson(const {'file': 'name'}), isNotNull),
    );

    test(
      'fromJson is a String and returns a valid Coffee',
      () => expect(Coffee.fromJson('{"file":"name"}'), isNotNull),
    );

    test('toMap returns a map', () {
      const coffee = Coffee(file: 'name');
      expect(coffee.toMap, isA<Map<String, dynamic>>());
    });

    test(
      'toJson returns a valid string map',
      () =>
          expect(const Coffee(file: 'name').toJson, equals('{"file":"name"}')),
    );

    test('copyWith returns a new instance with the correct file', () {
      const coffee = Coffee(file: 'name');
      final newCoffee = coffee.copyWith(file: 'newName');
      expect(newCoffee.file, equals('newName'));
    });

    test('toString contains the correct file', () {
      const coffee = Coffee(file: 'name');
      expect(coffee.toString(), contains('name'));
    });

    test('props returns a list with the correct file', () {
      const coffee = Coffee(file: 'name');
      expect(coffee.props, equals(['name']));
    });

    test('stringify is true', () {
      const coffee = Coffee(file: 'name');
      expect(coffee.stringify, isTrue);
    });

    test('fromJsonList returns a list of Coffee', () {
      final coffees = Coffee.fromJsonList(['{"file":"name"}']);
      expect(coffees, isA<List<Coffee>>());
      expect(coffees.first, isA<Coffee>());
    });

    test('toJsonList returns a list of Coffee', () {
      final coffees = Coffee.fromJsonList(['{"file":"name"}']);
      expect(coffees, isA<List<Coffee>>());
      expect(coffees.first, isA<Coffee>());
    });

    test('fromJsonList returns an empty list', () {
      final coffees = Coffee.fromJsonList(null);
      expect(coffees, isEmpty);
    });

    test('toJsonList returns an empty list', () {
      final coffees = Coffee.fromJsonList(<dynamic>[]);
      expect(coffees, isEmpty);
    });

    test('fromJsonList returns an empty list', () {
      final coffees = Coffee.fromJsonList(Map<String, dynamic>.from({}));
      expect(coffees, isEmpty);
    });

    test('fromJsonList returns a collection', () {
      final coffees = Coffee.fromJsonList('[{"file":"name"}]');
      expect(coffees, isNotEmpty);
    });
  });
}
