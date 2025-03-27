import 'package:app/presentation/coffee/screen/coffee_screen.dart';
import 'package:app/presentation/favorites/screen/favorites_screen.dart';
import 'package:app/presentation/router/constants_router.dart';
import 'package:app/presentation/router/vgc_screen_enum.dart';
import 'package:go_router/go_router.dart';

class VgcRouter {
  GoRouter get router => GoRouter(
    initialLocation: VgcScreenEnum.root.path,
    navigatorKey: ConstantsRouter.rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: ConstantsRouter.rootNavigatorKey,
        path: VgcScreenEnum.root.path,
        name: VgcScreenEnum.root.path,
        builder: (_, __) => const CoffeeScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: ConstantsRouter.rootNavigatorKey,
            path: VgcScreenEnum.favorites.path,
            name: VgcScreenEnum.favorites.path,
            builder: (_, __) => const FavoritesScreen(),
          ),
        ],
      ),
    ],
  );
}
