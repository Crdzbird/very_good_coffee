import 'package:app/presentation/app/screen/app_screen.dart';
import 'package:app/presentation/coffee/screen/coffee_screen.dart';
import 'package:app/presentation/favorites/view/favorites_view.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:models/models.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/mocks.mocks.dart';

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

    testWidgets(
      'renders AppView',
      (tester) => mockNetworkImages(() async {
        await tester.pumpWidget(
          AppScreen(
            coffeeClient: coffeeClientRepository,
            localCoffeeDatasource: localCoffeeDatasource,
            coffeeRepository: coffeeRepository,
          ),
        );
        expect(find.byType(CoffeeScreen), findsOneWidget);
      }),
    );

    testWidgets('renders CoffeeView and taps on favorite', (tester) async {
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);
      await tester.tap(find.byKey(const Key('like')));
      await tester.pumpAndSettle();
      verify(coffeeRepository.fetch()).called(2);
    });

    testWidgets('renders CoffeeView and taps on not favorite', (tester) async {
      when(coffeeRepository.save(Coffee())).thenAnswer((_) async {});
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);

      await tester.tap(find.byKey(const Key('dislike')));
      await tester.pumpAndSettle();
      verify(coffeeRepository.fetch()).called(2);
    });

    testWidgets('renders CoffeeView and drag to not favorite', (tester) async {
      when(coffeeRepository.save(Coffee())).thenAnswer((_) async {});
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);
      await tester.drag(find.byKey(Key('coffee_card')), const Offset(-110, 0));
      await tester.pumpAndSettle();
      verify(coffeeRepository.fetch()).called(2);
    });

    testWidgets('renders CoffeeView and drags on favorite', (tester) async {
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);
      await tester.drag(find.byKey(Key('coffee_card')), const Offset(110, 0));
      await tester.pumpAndSettle();
      verify(coffeeRepository.fetch()).called(2);
    });

    testWidgets('Error widget render', (tester) async {
      when(
        coffeeRepository.fetch(),
      ).thenAnswer((_) async => ('Fake Error', null));
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pump(Durations.medium2);
      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets('go to favorites screen', (tester) async {
      when(coffeeRepository.fetchAllLocal()).thenReturn([]);
      await tester.pumpWidget(
        AppScreen(
          coffeeClient: coffeeClientRepository,
          localCoffeeDatasource: localCoffeeDatasource,
          coffeeRepository: coffeeRepository,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CoffeeScreen), findsOneWidget);
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesView), findsOneWidget);
    });
  });
}
