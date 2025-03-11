import 'package:app/presentation/app/provider/app_provider.dart';
import 'package:app/presentation/coffee/coffee_screen.dart';
import 'package:app/presentation/favorites/favorites_screen.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:models/models.dart';

import '../../helpers/helpers.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  group('App', () {
    late CoffeeClientRepository coffeeClientRepository;
    late LocalCoffeeRepository localCoffeeRepository;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeClientRepository = MockCoffeeClient();
      localCoffeeRepository = MockLocalCoffeeUsecase();
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

    testWidgets(
      'renders AppView',
      (tester) => mockNetworkImages(() async {
        await tester.pumpWidget(
          AppProvider(
            coffeeSealed: coffeeClientRepository,
            localCoffeeRepository: localCoffeeRepository,
            coffeeRepository: coffeeRepository,
          ),
        );
        expect(find.byType(CoffeeScreen), findsOneWidget);
      }),
    );

    testWidgets('renders CoffeeScreen and taps on refresh', (tester) async {
      await tester.pumpWidget(
        AppProvider(
          coffeeSealed: coffeeClientRepository,
          localCoffeeRepository: localCoffeeRepository,
          coffeeRepository: coffeeRepository,
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pumpAndSettle();

      verify(coffeeRepository.fetch()).called(2);
    });

    testWidgets('renders CoffeeScreen and taps on save favorite', (
      tester,
    ) async {
      when(coffeeRepository.save(Coffee())).thenAnswer((_) async {});
      await tester.pumpApp(
        AppProvider(
          coffeeSealed: coffeeClientRepository,
          localCoffeeRepository: localCoffeeRepository,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);

      final switchFinder = find.byType(Switch);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();
      final switchWidget = tester.widget<Switch>(switchFinder);
      expect(switchWidget.value, true);
    });

    testWidgets(
      'renders CoffeeScreen and taps on save favorite, then remove it',
      (tester) async {
        when(coffeeRepository.save(Coffee())).thenAnswer((_) async {});
        when(coffeeRepository.delete(Coffee())).thenAnswer((_) async {});

        await tester.pumpApp(
          AppProvider(
            coffeeSealed: coffeeClientRepository,
            localCoffeeRepository: localCoffeeRepository,
            coffeeRepository: coffeeRepository,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(CoffeeScreen), findsOneWidget);

        final switchFinder = find.byType(Switch);
        await tester.tap(switchFinder);
        await tester.pumpAndSettle();
        final switchWidget = tester.widget<Switch>(switchFinder);
        expect(switchWidget.value, true);

        await tester.tap(switchFinder);
        await tester.pumpAndSettle();
        final switchWidget2 = tester.widget<Switch>(switchFinder);
        expect(switchWidget2.value, false);
      },
    );

    testWidgets('Error widget render', (tester) async {
      when(
        coffeeRepository.fetch(),
      ).thenAnswer((_) async => ('Fake Error', null));
      await tester.pumpApp(
        AppProvider(
          coffeeSealed: coffeeClientRepository,
          localCoffeeRepository: localCoffeeRepository,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Fake Error'), findsOneWidget);
    });

    testWidgets('go to favorites screen', (tester) async {
      when(coffeeRepository.fetchAllLocal()).thenReturn([]);
      await tester.pumpApp(
        AppProvider(
          coffeeSealed: coffeeClientRepository,
          localCoffeeRepository: localCoffeeRepository,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesScreen), findsOneWidget);
    });
  });
}
