import 'package:app/presentation/app/screen/app_screen.dart';
import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:app/presentation/favorite_detail/screen/favorite_detail_screen.dart';
import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:app/presentation/favorites/view/favorites_view.dart';
import 'package:app/presentation/favorites/widgets/favorite_gridview.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';

import '../helpers/mocks.mocks.dart';
import '../helpers/pump_app.dart';

void main() {
  group('App', () {
    late CoffeeApiClientDatasource coffeeClientRepository;
    late LocalCoffeeDatasource localCoffeeDatasource;
    late CoffeeRepository coffeeRepository;

    late FavoritesCubit favoritesCubit;
    late FavoritesCubit favoritesCubitStub;
    late CoffeeCubit coffeeCubit;

    setUp(() {
      coffeeClientRepository = MockCoffeeApiClient();
      localCoffeeDatasource = MockLocalCoffeeUsecase();
      coffeeRepository = MockCoffeeUsecase();
      favoritesCubit = MockFavoritesCubit();
      coffeeCubit = MockCoffeeCubit();
      favoritesCubitStub = FavoritesCubit(
        coffeeRepository: coffeeRepository,
        coffeeCubit: coffeeCubit,
      );

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
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();
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

    testWidgets('Favorite onLoading', (tester) async {
      provideDummy<FavoritesState>(FavoritesLoading());
      when(coffeeRepository.fetchAllLocal()).thenReturn([
        Coffee(file: 'https://coffee.alexflipnote.dev/2cuNGfDh1V0_coffee.png'),
      ]);
      when(favoritesCubit.state).thenReturn(FavoritesLoading());
      when(
        coffeeCubit.stream,
      ).thenAnswer((_) => Stream<CoffeeState>.fromIterable([CoffeeLoading()]));
      when(coffeeRepository.fetch()).thenAnswer(
        (_) async => (
          null,
          Coffee(
            file: 'https://coffee.alexflipnote.dev/2cuNGfDh1V0_coffee.png',
          ),
        ),
      );
      await tester.pumpApp(
        RepositoryProvider<CoffeeRepository>(
          create:
              (rContext) => CoffeeUsecase(
                coffeeClient: coffeeClientRepository,
                localCoffeeDatasource: localCoffeeDatasource,
              ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: coffeeCubit),
              BlocProvider.value(value: favoritesCubitStub),
            ],
            child: FavoritesView(),
          ),
        ),
      );
      await tester.pump(Durations.short1);
      expect(find.byType(FavoriteGridview), findsAny);
    });

    testWidgets('Go to detail favorite from the first element', (tester) async {
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
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
      expect(find.byType(FavoritesView), findsNothing);
      expect(find.byType(FavoriteDetailScreen), findsOneWidget);
    });
  });
}
