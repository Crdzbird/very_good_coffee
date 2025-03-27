import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextCoffee extends StatelessWidget {
  const NextCoffee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeCubit, CoffeeState>(
      builder: (bContext, state) {
        return switch (state) {
          CoffeeLoading() || CoffeeError() => FloatingActionButton(
            onPressed: null,
            child: const Icon(Icons.skip_next),
          ),
          CoffeeLoaded() => FloatingActionButton(
            onPressed: bContext.read<CoffeeCubit>().fetchCoffee,
            child: const Icon(Icons.skip_next),
          ),
        };
      },
    );
  }
}
