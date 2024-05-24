import 'package:flutter/material.dart';
import 'package:pet_mobile/model/project.dart'; //isso serve pra que mesmo?
import 'package:pet_mobile/pages/descricao_projeto_page.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';
import 'package:pet_mobile/provider/api_service.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({Key? key}) : super(key: key);

  @override
  State<ProjectsList> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  late Future<List<dynamic>> futureProjects;
  final ApiService apiService = ApiService(UrlAppend: 'projetos/');

  @override
  void initState() {
    super.initState();
    futureProjects = apiService.fetchData();
  }

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
              Color(0xFF61CFD7),
            ],
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<List<dynamic>>(
            future: futureProjects,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Nenhum projeto encontrado'));
              } else {
                List<dynamic> projectsList = snapshot.data!;
                return Container(
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
                      var project = projectsList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescricaoProjeto(
                                nomeProjeto: project['titulo'],
                              ),
                            ),
                          );
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
                                      project['imagem'], 
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    project['titulo'], 
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}