import 'package:flutter/material.dart';
import 'package:pet_mobile/pages/activities_page.dart';
import 'package:pet_mobile/pages/descricao_projeto_page.dart';
import 'package:pet_mobile/pages/profile_page/profile_page.dart';
import 'package:pet_mobile/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'pages/meet_page.dart';
import 'pages/cadastro_petiano.dart';
import 'pages/criar_grupo.dart';
import 'package:pet_mobile/pages/calendar_page.dart';
import 'package:pet_mobile/pages/help_page.dart';
import 'package:pet_mobile/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/pages/adicionar_projeto_page.dart';
import 'package:pet_mobile/pages/marcar_atividades.dart';
import 'package:pet_mobile/pages/projectsList.dart';

import 'pages/login_page.dart';
import 'config/themes/theme.dart';

// Widget principal do app.
// Aqui são configurados:
// - Tema.
// - Internacionalização, locales.
// - Rotas, pages.
class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
        ),
      ],
      child: MaterialApp(
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
            '/calendar': (context) => CalendarPage(),
            '/register/petiano': (context) => CadasPetiano(),
            '/register/group': (context) => CriarGrupo(),
            '/meet': (context) => MeetPage(),
            '/login': (context) => LoginPage(),
            '/projects': (context) => ProjectsList(),
            '/register/project': (context) => AdicionarProjeto(),
            '/activities': (context) => Atividade(),
            '/project/description': (context) => DescricaoProjeto(),
            '/adicionarProjeto': (context) => MarcarAtividadePage(),
            '/profile': (context) => ProfilePage()
          }),
    );
  }
}
