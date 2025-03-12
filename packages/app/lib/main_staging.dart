import 'package:app/bootstrap.dart';
import 'package:app/presentation/app/screen/app_screen.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final coffeeClient = CoffeeApiClient();
  final localCoffeeDatasource = LocalCoffeeUsecase(sharedPreferences);
  final coffeeRepository = CoffeeUsecase(
    coffeeClient: coffeeClient,
    localCoffeeDatasource: localCoffeeDatasource,
  );

  await bootstrap(
    () => AppScreen(
      coffeeClient: coffeeClient,
      coffeeRepository: coffeeRepository,
      localCoffeeDatasource: localCoffeeDatasource,
    ),
  );
}
