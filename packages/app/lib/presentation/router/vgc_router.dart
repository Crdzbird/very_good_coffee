import 'package:app/presentation/coffee/screen/coffee_screen.dart';
import 'package:app/presentation/favorites/screen/favorites_screen.dart';
import 'package:app/presentation/router/constants_router.dart';
import 'package:go_router/go_router.dart';

class VgcRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/',
    navigatorKey: ConstantsRouter.rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: ConstantsRouter.rootNavigatorKey,
        path: '/',
        name: '/',
        builder: (_, __) => const CoffeeScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: ConstantsRouter.rootNavigatorKey,
            path: 'favorites',
            name: 'favorites',
            builder: (_, __) => const FavoritesScreen(),
          ),
        ],
      ),
    ],
  );
}
