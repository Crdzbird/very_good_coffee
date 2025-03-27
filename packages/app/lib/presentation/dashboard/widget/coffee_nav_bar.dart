import 'package:app/presentation/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CoffeeNavBar extends StatelessWidget {
  const CoffeeNavBar({super.key, int index = 0, ValueChanged<int>? onTap})
    : _index = index,
      _onTap = onTap;

  final int _index;
  final ValueChanged<int>? _onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.coffee),
          label: context.l10n.coffees,
          tooltip: context.l10n.coffees,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: context.l10n.favorites,
          tooltip: context.l10n.favorites,
        ),
      ],
    );
  }
}
