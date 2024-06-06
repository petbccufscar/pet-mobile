import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

import 'package:pet_mobile/pages/profile_page/profile_page.dart';
import 'package:pet_mobile/pages/activities_page.dart';
import 'package:pet_mobile/pages/meet_page.dart';
import 'package:pet_mobile/pages/mural_page.dart';

class HomePage extends StatelessWidget {
  final List<String> projects = [
    "Arca do Cerrado",
    "Pet-Mobile",
    "Pet-Saúde",
    // Adicione os projetos reais aqui
  ];

  final List<String> members = [
    "João Otávio",
    "Caio Ueda",
    "Caio Cadini",
    "Adriano",
    // Adicione os membros reais aqui
  ];

  final List<String> meetings = [
    "Reunião Geral",
    "Reunião Arca",
    "Reunião Acompanhamento",
    // Adicione as reuniões reais aqui
  ];

  final List<String> activities = [
    "Desenvolver backend",
    "Arrumar o Drive",
    "Pesquisar conteúdos",
    // Adicione as atividades reais aqui
  ];

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text(AppLocalizations.of(context)!.home_page_title),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildSection(context, "Projetos", projects, MuralProjeto(), false),
          _buildSection(context, "Reuniões", meetings, MeetPage(), false),
          _buildSection(context, "Atividades", activities, Atividade(), false),
          _buildSection(context, "Integrantes", members, ProfilePage(), true),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> items,
      Widget nextPage, bool isMembersSection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        isMembersSection
            ? _buildMembersList(context, items)
            : _buildItemList(context, items, nextPage),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMembersList(BuildContext context, List<String> members) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: members.length,
        itemBuilder: (context, index) {
          return _buildMemberCard(context, members[index]);
        },
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, String memberName) {
    // Aqui você pode buscar a foto do integrante no banco de dados
    String memberImageUrl =
        'https://petbcc.ufscar.br/media/images/equipe/IMG_20210403_142933_015.jpg_SDflxTe.png'; // Substitua pela URL real da imagem

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(memberName: memberName)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(memberImageUrl),
            ),
            SizedBox(height: 8),
            Text(
              memberName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(BuildContext context, List<String> items, Widget nextPage) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          },
        );
      },
    );
  }
}
