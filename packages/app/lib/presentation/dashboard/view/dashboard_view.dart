import 'package:app/presentation/dashboard/widget/coffee_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;
  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: CoffeeNavBar(
        index: _navigationShell.currentIndex,
        onTap: _navigationShell.goBranch,
      ),
    );
  }
}
