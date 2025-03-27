import 'package:app/presentation/router/constants_router.dart';
import 'package:app/presentation/router/tabs/coffee_tab_route.dart';
import 'package:app/presentation/router/vgc_screen_enum.dart';
import 'package:go_router/go_router.dart';

class VgcRouter {
  GoRouter get router => GoRouter(
    initialLocation: VgcScreenEnum.coffees.path,
    navigatorKey: ConstantsRouter.rootNavigatorKey,
    routes: [CoffeeTabRoute.coffeeTabRoute],
  );
}
