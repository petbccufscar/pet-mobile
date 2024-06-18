import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';
import 'package:pet_mobile/provider/api_service.dart';
import 'package:pet_mobile/pages/profile_page.dart';
import 'package:pet_mobile/pages/activities_page.dart';
import 'package:pet_mobile/pages/meet_page.dart';
import 'package:pet_mobile/pages/mural_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> futureProjects;
  late Future<List<dynamic>> futureMeetings;
  late Future<List<dynamic>> futureActivities;
  late Future<List<dynamic>> futureMembers;

  final ApiService projectsApiService = ApiService(UrlAppend: 'projetos/');
  final ApiService meetingsApiService = ApiService(UrlAppend: 'eventos/');
  final ApiService activitiesApiService = ApiService(UrlAppend: 'atividades/');
  final ApiService membersApiService = ApiService(UrlAppend: 'perfis/');

  @override
  void initState() {
    super.initState();
    futureProjects = projectsApiService.fetchData();
    futureMeetings = meetingsApiService.fetchData();
    futureActivities = activitiesApiService.fetchData();
    futureMembers = membersApiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text(AppLocalizations.of(context)!.home_page_title),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildProjectsSection(context),
          _buildMeetingsSection(context),
          _buildActivitiesSection(context),
          _buildMembersSection(context),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureProjects,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum projeto encontrado'));
        } else {
          List<dynamic> projects = snapshot.data!;
          return _buildSection(context, "Projetos", projects, MuralProjeto(), false);
        }
      },
    );
  }

  Widget _buildMeetingsSection(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureMeetings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhuma reunião encontrada'));
        } else {
          List<dynamic> meetings = snapshot.data!;
          return _buildSection(context, "Reuniões", meetings, MeetPage(), false);
        }
      },
    );
  }

  Widget _buildActivitiesSection(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureActivities,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhuma atividade encontrada'));
        } else {
          List<dynamic> activities = snapshot.data!;
          return _buildSection(context, "Atividades", activities, Atividade(), false);
        }
      },
    );
  }

  Widget _buildMembersSection(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureMembers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum integrante encontrado'));
        } else {
          List<dynamic> members = snapshot.data!;
          return _buildSection(context, "Integrantes", members, ProfilePage(), true);
        }
      },
    );
  }

  Widget _buildSection(BuildContext context, String title, List<dynamic> items,
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

  Widget _buildMembersList(BuildContext context, List<dynamic> members) {
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

  Widget _buildMemberCard(BuildContext context, dynamic member) {
    String memberName = member['nome'] ?? 'Nome não disponível';
    String memberImageUrl = member['imagem'] ?? 'https://petbcc.ufscar.br/media/images/equipe/IMG_20210403_142933_015.jpg_SDflxTe.png'; // URL padrão para a imagem

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(memberName: memberName)),
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

  Widget _buildItemList(BuildContext context, List<dynamic> items, Widget nextPage) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]['titulo'] ?? 'Título não disponível'), // Adiciona verificação de nulidade
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