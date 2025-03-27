import 'package:app/presentation/coffee/bloc/coffee_cubit.dart';
import 'package:app/presentation/coffee/widgets/coffee_content.dart';
import 'package:app/presentation/router/vgc_screen_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoffeeView extends StatelessWidget {
  const CoffeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coffee')),
      body: const CoffeeContent(),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          onPressed: () => context.go(VgcScreenEnum.favorites.initSlash),
          child: Text('Favorites'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<CoffeeCubit>().fetchCoffee,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
