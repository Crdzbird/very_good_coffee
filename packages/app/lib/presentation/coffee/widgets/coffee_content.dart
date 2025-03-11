import 'package:app/presentation/coffee/bloc/coffee_bloc.dart';
import 'package:app/presentation/coffee/widgets/vgc_coffee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeContent extends StatelessWidget {
  const CoffeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (bContext, state) {
        if (state is CoffeeLoading) {
          return const CircularProgressIndicator.adaptive();
        }
        if (state is CoffeeError) {
          return Text(state.message);
        }
        return VgcCoffeeCard(
          coffee: (state as CoffeeLoaded).coffee,
          isFavorite: state.isFavorite,
        );
      },
    );
  }
}
