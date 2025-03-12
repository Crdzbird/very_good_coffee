import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';

import 'coffee_usecase_test.mocks.dart';

@GenerateMocks([CoffeeApiClient, LocalCoffeeUsecase])
void main() {
  late CoffeeUsecase coffeeUsecase;
  late CoffeeApiClientDatasource coffeeClient;
  late LocalCoffeeDatasource localCoffeeDatasource;

  setUpAll(() {
    coffeeClient = MockCoffeeApiClient();
    localCoffeeDatasource = MockLocalCoffeeUsecase();
    coffeeUsecase = CoffeeUsecase(
      coffeeClient: coffeeClient,
      localCoffeeDatasource: localCoffeeDatasource,
    );
    provideDummy<Coffee>(Coffee(file: 'dummy'));
  });

  group('CoffeeUsecase', () {
    test(
      'fetch returns result from CoffeeApiClientDatasource when result.error is null',
      () async {
        final coffee = Coffee(file: 'dummy');
        when(
          coffeeClient.fetchCoffee(),
        ).thenAnswer((_) async => (null, coffee));
        final result = await coffeeUsecase.fetch();
        expect(result, (null, coffee));
      },
    );

    test('save calls localCoffeeDatasource.save', () async {
      final coffee = Coffee(file: 'dummy');
      when(localCoffeeDatasource.save(coffee)).thenAnswer((_) async {});
      await coffeeUsecase.save(coffee);
      verify(localCoffeeDatasource.save(coffee)).called(1);
    });

    test('delete calls localCoffeeDatasource.delete', () async {
      final coffee = Coffee(file: 'dummy');
      when(localCoffeeDatasource.delete(coffee)).thenAnswer((_) async {});
      await coffeeUsecase.delete(coffee);
      verify(localCoffeeDatasource.delete(coffee)).called(1);
    });

    test(
      'fetch returns result from CoffeeApiClientDatasource when result.error is not null and localCoffeeDatasource.fetchRandom is not empty',
      () async {
        when(
          coffeeClient.fetchCoffee(),
        ).thenAnswer((_) async => ('error', null));
        when(
          localCoffeeDatasource.fetchRandom(),
        ).thenReturn(Coffee(file: 'dummy'));

        final result = await coffeeUsecase.fetch();
        expect(result, (null, Coffee(file: 'dummy')));
      },
    );

    test(
      'fetch returns result from CoffeeApiClientDatasource when result.error is not null and localCoffeeDatasource.fetchRandom is empty',
      () async {
        when(
          coffeeClient.fetchCoffee(),
        ).thenAnswer((_) async => ('error', null));
        when(localCoffeeDatasource.fetchRandom()).thenReturn(Coffee(file: ''));

        final result = await coffeeUsecase.fetch();
        expect(result, ('error', null));
      },
    );

    test('fetchAllLocal returns all local coffees', () {
      final coffees = [Coffee(file: 'file1'), Coffee(file: 'file2')];
      when(localCoffeeDatasource.fetchAll()).thenReturn(coffees);

      final result = coffeeUsecase.fetchAllLocal();

      expect(result, coffees);
      verify(localCoffeeDatasource.fetchAll()).called(1);
    });
  });
}
