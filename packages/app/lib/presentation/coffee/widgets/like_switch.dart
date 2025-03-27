import 'package:flutter/material.dart';

class LikeSwitch extends StatelessWidget {
  const LikeSwitch({super.key, bool liked = false}) : _liked = liked;
  final bool _liked;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium2,
      transitionBuilder:
          (child, animation) => ScaleTransition(scale: animation, child: child),
      child: Icon(
        _liked ? Icons.favorite : Icons.favorite_border,
        key: ValueKey<bool>(_liked),
      ),
    );
  }
}
