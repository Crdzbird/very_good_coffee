import 'package:app/presentation/coffee/bloc/coffee_bloc.dart';
import 'package:app/presentation/coffee/widgets/coffee_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coffee')),
      body: const CoffeeContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<CoffeeBloc>().fetchCoffee,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
