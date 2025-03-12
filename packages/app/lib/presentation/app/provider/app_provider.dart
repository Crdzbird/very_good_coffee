import 'package:app/presentation/app/view/app.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({
    super.key,
    required CoffeeApiClientDatasource coffeeClient,
    required LocalCoffeeDatasource localCoffeeDatasource,
    required CoffeeRepository coffeeRepository,
  }) : _coffeeClient = coffeeClient,
       _localCoffeeDatasource = localCoffeeDatasource,
       _coffeeRepository = coffeeRepository;
  final CoffeeApiClientDatasource _coffeeClient;
  final LocalCoffeeDatasource _localCoffeeDatasource;
  final CoffeeRepository _coffeeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _coffeeClient),
        RepositoryProvider.value(value: _localCoffeeDatasource),
        RepositoryProvider.value(value: _coffeeRepository),
      ],
      child: App(),
    );
  }
}
