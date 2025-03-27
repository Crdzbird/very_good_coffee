import 'package:app/presentation/coffee/widgets/vgc_coffee_card.dart';
import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:app/presentation/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeContent extends StatelessWidget {
  const CoffeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        spacing: 8,
        children: [
          Spacer(),
          BlocBuilder<CoffeeCubit, CoffeeState>(
            builder: (bContext, state) {
              return switch (state) {
                CoffeeLoading() || CoffeeError() => VgcCoffeeCard.shimmer(),
                CoffeeLoaded() => VgcCoffeeCard.coffee(
                  coffee: state.coffee,
                  isFavorite: state.isFavorite,
                ),
              };
            },
          ),
          Spacer(),
          BlocBuilder<CoffeeCubit, CoffeeState>(
            builder: (bContext, state) {
              return switch (state) {
                CoffeeLoading() || CoffeeError() => Row(
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: null,
                      shape: const CircleBorder(),
                      child: Icon(Icons.close),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: null,
                      shape: const CircleBorder(),
                      child: Icon(Icons.favorite),
                    ),
                  ],
                ).shimmer(bContext),
                CoffeeLoaded() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      shape: const CircleBorder(),

                      onPressed: context.read<CoffeeCubit>().fetchCoffee,
                      child: Icon(Icons.close),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      heroTag: null,
                      shape: const CircleBorder(),
                      onPressed:
                          () => context.read<CoffeeCubit>().saveCoffee(
                            state.coffee,
                          ),
                      child: Icon(Icons.favorite),
                    ),
                  ],
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}
