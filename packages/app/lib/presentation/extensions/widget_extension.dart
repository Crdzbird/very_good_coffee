import 'dart:ui';

import 'package:app/presentation/extensions/build_context_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

extension WidgetExtension on Widget {
  Widget shimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.theme.colorScheme.primary,
      highlightColor: context.theme.colorScheme.secondary.withValues(
        alpha: 0.2,
      ),
      enabled: true,
      child: this,
    );
  }

  Widget blur() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: this,
      ),
    );
  }
}
