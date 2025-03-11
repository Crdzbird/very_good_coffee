import 'package:app/presentation/app/view/app.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({
    super.key,
    required CoffeeClientRepository coffeeSealed,
    required LocalCoffeeRepository localCoffeeRepository,
    required CoffeeRepository coffeeRepository,
  }) : _coffeeSealed = coffeeSealed,
       _localCoffeeRepository = localCoffeeRepository,
       _coffeeRepository = coffeeRepository;
  final CoffeeClientRepository _coffeeSealed;
  final LocalCoffeeRepository _localCoffeeRepository;
  final CoffeeRepository _coffeeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _coffeeSealed),
        RepositoryProvider.value(value: _localCoffeeRepository),
        RepositoryProvider.value(value: _coffeeRepository),
      ],
      child: App(),
    );
  }
}
