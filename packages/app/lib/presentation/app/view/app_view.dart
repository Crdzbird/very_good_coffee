import 'package:app/presentation/app/utils/locale_resolution.dart';
import 'package:app/presentation/app/utils/platform_scroll_behavior.dart';
import 'package:app/presentation/extensions/build_context_extension.dart';
import 'package:app/presentation/l10n/arb/app_localizations.dart';
import 'package:app/presentation/router/vgc_router.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: context.themeModes.$1,
      darkTheme: context.themeModes.$2,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: localeResolution,
      scrollBehavior: PlatformScrollBehavior(),
      routerConfig: VgcRouter().router,
    );
  }
}
