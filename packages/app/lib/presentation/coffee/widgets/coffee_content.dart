import 'package:app/presentation/coffee/widgets/vgc_coffee_card.dart';
import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeContent extends StatelessWidget {
  const CoffeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: context.read<CoffeeCubit>().fetchCoffee,
      child: CustomScrollView(
        slivers: [
          BlocBuilder<CoffeeCubit, CoffeeState>(
            builder: (bContext, state) {
              return switch (state) {
                CoffeeLoading() || CoffeeError() => SliverFillRemaining(
                  child: VgcCoffeeCard.shimmer(),
                ),
                CoffeeLoaded() => SliverFillRemaining(
                  child: VgcCoffeeCard.coffee(
                    coffee: state.coffee,
                    isFavorite: state.isFavorite,
                  ),
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}
