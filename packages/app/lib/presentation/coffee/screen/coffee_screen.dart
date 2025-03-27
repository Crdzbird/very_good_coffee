import 'package:app/presentation/coffee/widgets/coffee_content.dart';
import 'package:app/presentation/coffee/widgets/next_coffee.dart';
import 'package:flutter/material.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CoffeeContent(),
      floatingActionButton: NextCoffee(),
    );
  }
}
