import 'package:app/presentation/l10n/arb/app_localizations.dart';
import 'package:app/presentation/router/vgc_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: VgcRouter().router,
    );
  }
}
