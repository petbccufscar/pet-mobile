import 'package:flutter/material.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

class Atividade extends StatelessWidget {
  const Atividade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
        appBarTitle: Text('Atividades'), body: Container());
  }
}
