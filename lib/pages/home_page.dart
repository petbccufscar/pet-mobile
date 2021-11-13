import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffold(
      appBarTitle: Text(AppLocalizations.of(context)!.home_page_title),
      body: Container(),
    );
  }
}