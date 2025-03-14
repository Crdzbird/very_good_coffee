import 'package:flutter_test/flutter_test.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';

import 'local_coffe_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LocalCoffeeDatasource localCoffeeDatasource;
  late SharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localCoffeeDatasource = LocalCoffeeUsecase(mockSharedPreferences);
  });

  group('LocalCoffeeUsecase', () {
    test('fetchAll returns list of coffees', () {
      when(
        mockSharedPreferences.getStringList(LocalEnums.coffee.name),
      ).thenReturn(['{"file": "Espresso"}']);
      final coffees = localCoffeeDatasource.fetchAll();
      expect(coffees.length, 1);
      expect(coffees.first.file, 'Espresso');
    });

    test('fetchAll returns empty list when no coffees are saved', () {
      when(
        mockSharedPreferences.getStringList(LocalEnums.coffee.name),
      ).thenReturn(null);
      final coffees = localCoffeeDatasource.fetchAll();
      expect(coffees, isEmpty);
    });

    test('save adds a coffee to the list', () async {
      when(
        mockSharedPreferences.getStringList(LocalEnums.coffee.name),
      ).thenReturn([]);
      when(
        mockSharedPreferences.setStringList(LocalEnums.coffee.name, [
          '{"file":"Latte"}',
        ]),
      ).thenAnswer((_) async => true);

      final coffee = Coffee(file: 'Latte');
      await localCoffeeDatasource.save(coffee);

      verify(
        mockSharedPreferences.setStringList(LocalEnums.coffee.name, [
          coffee.toJson,
        ]),
      ).called(1);
    });

    test('delete removes a coffee from the list', () async {
      final coffee = Coffee(file: 'Cappuccino');
      when(
        mockSharedPreferences.getStringList(LocalEnums.coffee.name),
      ).thenReturn([coffee.toJson]);
      when(
        mockSharedPreferences.setStringList(LocalEnums.coffee.name, []),
      ).thenAnswer((_) async => true);

      await localCoffeeDatasource.delete(coffee);

      verify(
        mockSharedPreferences.setStringList(LocalEnums.coffee.name, []),
      ).called(1);
    });

    test('fetchRandom returns a random coffee', () {
      final coffee = Coffee(file: 'Cappuccino');
      when(
        mockSharedPreferences.getStringList(LocalEnums.coffee.name),
      ).thenReturn([coffee.toJson]);

      final randomCoffee = localCoffeeDatasource.fetchRandom();
      expect(randomCoffee.file, 'Cappuccino');
    });
  });
}
