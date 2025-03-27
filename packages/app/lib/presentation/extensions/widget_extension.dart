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
}
