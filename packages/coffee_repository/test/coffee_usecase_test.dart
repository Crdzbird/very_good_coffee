import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';

import 'coffee_usecase_test.mocks.dart';

@GenerateMocks([CoffeeClient, LocalCoffeeUsecase])
void main() {
  late CoffeeUsecase coffeeUsecase;
  late CoffeeClientRepository coffeeClient;
  late LocalCoffeeRepository localCoffeeRepository;

  setUpAll(() {
    coffeeClient = MockCoffeeClient();
    localCoffeeRepository = MockLocalCoffeeUsecase();
    coffeeUsecase = CoffeeUsecase(
      coffeeClient: coffeeClient,
      localCoffeeRepository: localCoffeeRepository,
    );
    provideDummy<Coffee>(Coffee(file: 'dummy'));
  });

  group('CoffeeUsecase', () {
    test(
      'fetch returns result from CoffeeClientRepository when result.error is null',
      () async {
        final coffee = Coffee(file: 'dummy');
        when(
          coffeeClient.fetchCoffee(),
        ).thenAnswer((_) async => (null, coffee));
        final result = await coffeeUsecase.fetch();
        expect(result, (null, coffee));
      },
    );

    test('save calls localCoffeeRepository.save', () async {
      final coffee = Coffee(file: 'dummy');
      when(localCoffeeRepository.save(coffee)).thenAnswer((_) async {});
      await coffeeUsecase.save(coffee);
      verify(localCoffeeRepository.save(coffee)).called(1);
    });

    test('delete calls localCoffeeRepository.delete', () async {
      final coffee = Coffee(file: 'dummy');
      when(localCoffeeRepository.delete(coffee)).thenAnswer((_) async {});
      await coffeeUsecase.delete(coffee);
      verify(localCoffeeRepository.delete(coffee)).called(1);
    });

    test(
      'fetch returns result from CoffeeClientRepository when result.error is not null and localCoffeeRepository.fetchRandom is not empty',
      () async {
        when(
          coffeeClient.fetchCoffee(),
        ).thenAnswer((_) async => ('error', null));
        when(
          localCoffeeRepository.fetchRandom(),
        ).thenReturn(Coffee(file: 'dummy'));

        final result = await coffeeUsecase.fetch();
        expect(result, (null, Coffee(file: 'dummy')));
      },
    );

    test(
      'fetch returns result from CoffeeClientRepository when result.error is not null and localCoffeeRepository.fetchRandom is empty',
      () async {
        when(
          coffeeClient.fetchCoffee(),
        ).thenAnswer((_) async => ('error', null));
        when(localCoffeeRepository.fetchRandom()).thenReturn(Coffee(file: ''));

        final result = await coffeeUsecase.fetch();
        expect(result, ('error', null));
      },
    );

    test('fetchAllLocal returns all local coffees', () {
      final coffees = [Coffee(file: 'file1'), Coffee(file: 'file2')];
      when(localCoffeeRepository.fetchAll()).thenReturn(coffees);

      final result = coffeeUsecase.fetchAllLocal();

      expect(result, coffees);
      verify(localCoffeeRepository.fetchAll()).called(1);
    });
  });
}
