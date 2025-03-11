import 'package:app/presentation/coffee/provider/coffee_provider.dart';
import 'package:go_router/go_router.dart';

class VgcRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', name: '/', builder: (_, __) => const CoffeeProvider()),
    ],
  );
}
