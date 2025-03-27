import 'package:app/presentation/coffee/screen/coffee_screen.dart';
import 'package:app/presentation/dashboard/screen/dashboard_screen.dart';
import 'package:app/presentation/favorites/screen/favorites_screen.dart';
import 'package:app/presentation/router/constants_router.dart';
import 'package:app/presentation/router/vgc_screen_enum.dart';
import 'package:go_router/go_router.dart';

final class CoffeeTabRoute {
  factory CoffeeTabRoute() => _self;

  CoffeeTabRoute._internal();
  static final CoffeeTabRoute _self = CoffeeTabRoute._internal();

  static final coffeeTabRoute = StatefulShellRoute.indexedStack(
    key: ConstantsRouter.coffeeTabNavigatorKey,
    parentNavigatorKey: ConstantsRouter.rootNavigatorKey,
    builder:
        (_, __, navigationShell) =>
            DashboardScreen(navigationShell: navigationShell),
    branches: [
      StatefulShellBranch(
        initialLocation: VgcScreenEnum.coffees.path,
        routes: [
          GoRoute(
            path: VgcScreenEnum.coffees.path,
            name: VgcScreenEnum.coffees.path,
            builder: (context, state) => CoffeeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        initialLocation: VgcScreenEnum.favorites.path,
        routes: [
          GoRoute(
            path: VgcScreenEnum.favorites.path,
            name: VgcScreenEnum.favorites.path,
            builder: (context, state) => FavoritesScreen(),
          ),
        ],
      ),
    ],
  );
}
