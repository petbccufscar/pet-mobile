import 'package:flutter/material.dart';
import 'package:pet_mobile/model/project.dart';
import 'package:pet_mobile/pages/descricao_projeto_page.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({Key? key}) : super(key: key);

  @override
  State<ProjectsList> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  List<Project> projectsList = [
    Project(
        title: 'Aplicativo Sororidade',
        imageUrl: 'https://petbcc.ufscar.br/media/app-sororidade.jpg'),
    Project(
        title: 'Beecrowd', imageUrl: 'https://petbcc.ufscar.br/media/bee.png'),
    Project(
        title: 'Engenharia de Software Quântico',
        imageUrl: 'https://petbcc.ufscar.br/media/quantico.png'),
    Project(
        title: 'Iuten', imageUrl: 'https://petbcc.ufscar.br/media/Logo.png'),
    Project(
        title: 'Manual de Referências em C/C++',
        imageUrl: 'https://petbcc.ufscar.br/media/tutorial_linguagem_c.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text('Projetos'),
      appBarElevation: 0,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.blue,
              //Color(0xFF1485BF),
              Color(0xFF61CFD7),
            ])),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: projectsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescricaoProjeto()),
                    );
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectsList(
                          Project: projectsList[index],
                          projectHeroTag: 'project-$index',
                        ),
                      ),
                    );*/
                  },
                  child: Card(
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            child: Hero(
                              tag: 'project-$index',
                              child: Image.network(
                                projectsList[index].getImageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              projectsList[index].getTitle, // max 60 caracteres
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
