import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:app/presentation/dashboard/view/dashboard_view.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    required StatefulNavigationShell navigationShell,
    super.key,
  }) : _navigationShell = navigationShell;
  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (bContext) =>
              CoffeeCubit(coffeeRepository: bContext.read<CoffeeRepository>())
                ..fetchCoffee(),
      child: DashboardView(navigationShell: _navigationShell),
    );
  }
}
