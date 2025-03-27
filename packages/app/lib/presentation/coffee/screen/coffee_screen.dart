import 'package:app/presentation/coffee/widgets/coffee_content.dart';
import 'package:app/presentation/extensions/build_context_extension.dart';
import 'package:app/presentation/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.coffees)),
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: const CoffeeContent(),
      ),
    );
  }
}
