import 'package:app/presentation/coffee/bloc/coffee_bloc.dart';
import 'package:app/presentation/coffee/coffee_screen.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeProvider extends StatelessWidget {
  const CoffeeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (bContext) =>
              CoffeeBloc(coffeeRepository: bContext.read<CoffeeRepository>())
                ..fetchCoffee(),
      child: const CoffeeScreen(),
    );
  }
}
