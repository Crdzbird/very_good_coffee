import 'package:app/presentation/app/view/app.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({
    super.key,
    required CoffeeClientRepository coffeeClient,
    required LocalCoffeeRepository localCoffeeRepository,
    required CoffeeRepository coffeeRepository,
  }) : _coffeeClient = coffeeClient,
       _localCoffeeRepository = localCoffeeRepository,
       _coffeeRepository = coffeeRepository;
  final CoffeeClientRepository _coffeeClient;
  final LocalCoffeeRepository _localCoffeeRepository;
  final CoffeeRepository _coffeeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _coffeeClient),
        RepositoryProvider.value(value: _localCoffeeRepository),
        RepositoryProvider.value(value: _coffeeRepository),
      ],
      child: App(),
    );
  }
}
