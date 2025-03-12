import 'package:app/presentation/coffee/bloc/coffee_cubit.dart';
import 'package:app/presentation/coffee/widgets/vgc_coffee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeContent extends StatelessWidget {
  const CoffeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeCubit, CoffeeState>(
      builder: (bContext, state) {
        return switch (state) {
          CoffeeLoading() => const CircularProgressIndicator.adaptive(),
          CoffeeError() => Text(state.message),
          CoffeeLoaded() => VgcCoffeeCard(
            coffee: state.coffee,
            isFavorite: state.isFavorite,
          ),
        };
      },
    );
  }
}
