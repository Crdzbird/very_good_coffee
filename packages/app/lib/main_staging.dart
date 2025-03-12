import 'package:app/bootstrap.dart';
import 'package:app/presentation/app/provider/app_provider.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final coffeeClient = CoffeeClient();
  final localCoffeeRepository = LocalCoffeeUsecase(sharedPreferences);
  final coffeeRepository = CoffeeUsecase(
    coffeeClient: coffeeClient,
    localCoffeeRepository: localCoffeeRepository,
  );

  await bootstrap(
    () => AppProvider(
      coffeeClient: coffeeClient,
      coffeeRepository: coffeeRepository,
      localCoffeeRepository: localCoffeeRepository,
    ),
  );
}
