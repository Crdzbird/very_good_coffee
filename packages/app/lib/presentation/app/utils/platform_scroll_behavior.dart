import 'package:app/presentation/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class PlatformScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    if (context.isApple) return const BouncingScrollPhysics();
    return const MaterialScrollBehavior().getScrollPhysics(context);
  }
}
