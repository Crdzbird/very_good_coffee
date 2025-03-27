import 'package:flutter/material.dart';

class EmptyFavorite extends StatelessWidget {
  const EmptyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.new_releases_rounded, size: 100),
        const SizedBox(height: 16),
        Text('No favorites yet'),
      ],
    );
  }
}
