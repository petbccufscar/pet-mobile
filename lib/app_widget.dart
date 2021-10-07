import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_mobile/pages/help_page.dart';
import 'package:pet_mobile/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/pages/mural_page.dart';

import 'config/themes/theme.dart';

// Widget principal do app.
// Aqui são configurados:
// - Tema.
// - Internacionalização, locales.
// - Rotas, pages.
class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.title,
      theme: AppTheme.theme,
      // i18n
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Rotas
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/help': (context) => HelpPage(),
        '/mural': (context) => MuralProjeto()
      },
    );
  }
}
