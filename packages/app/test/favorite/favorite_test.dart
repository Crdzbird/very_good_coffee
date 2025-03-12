import 'package:app/presentation/app/screen/app_screen.dart';
import 'package:app/presentation/favorites/view/favorites_view.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';

import '../helpers/mocks.mocks.dart';

void main() {
  group('App', () {
    late CoffeeApiClientDatasource coffeeClientRepository;
    late LocalCoffeeDatasource localCoffeeDatasource;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeClientRepository = MockCoffeeApiClient();
      localCoffeeDatasource = MockLocalCoffeeUsecase();
      coffeeRepository = MockCoffeeUsecase();

      when(coffeeRepository.fetch()).thenAnswer(
        (_) async => (
          null,
          Coffee(
            file: 'https://coffee.alexflipnote.dev/2cuNGfDh1V0_coffee.png',
          ),
        ),
      );
    });

    testWidgets('go to favorites screen', (tester) async {
      when(coffeeRepository.fetchAllLocal()).thenReturn([
        Coffee(file: 'https://coffee.alexflipnote.dev/2cuNGfDh1V0_coffee.png'),
      ]);
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesView), findsOneWidget);
    });

    testWidgets('go to favorites screen and remove one element', (
      tester,
    ) async {
      when(coffeeRepository.fetchAllLocal()).thenReturn([
        Coffee(file: 'https://coffee.alexflipnote.dev/2cuNGfDh1V0_coffee.png'),
      ]);
      when(
        localCoffeeDatasource.delete(
          Coffee(
            file: 'https://coffee.alexflipnote.dev/2cuNGfDh1V0_coffee.png',
          ),
        ),
      ).thenAnswer((_) async {});
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesView), findsOneWidget);
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      verify(
        coffeeRepository.delete(
          Coffee(
            file: 'https://coffee.alexflipnote.dev/2cuNGfDh1V0_coffee.png',
          ),
        ),
      ).called(1);
    });
  });
}
