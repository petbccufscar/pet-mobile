
import 'package:flutter/material.dart';
import 'package:pet_mobile/provider/api_service.dart'; 

class DescricaoProjeto extends StatefulWidget {
  final String nomeProjeto;
  const DescricaoProjeto({Key? key, required this.nomeProjeto}) : super(key: key);

  @override
  State<DescricaoProjeto> createState() => _DescricaoProjetoState();
}

class _DescricaoProjetoState extends State<DescricaoProjeto> {
  late Future<List<dynamic>> futureProjects;
  final ApiService apiService = ApiService(UrlAppend: 'projetos/');

  @override
  void initState() {
    super.initState();
    futureProjects = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Descrição do projeto"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
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
            final project = projects.firstWhere(
            (projeto) => projeto['titulo'] != null && projeto['titulo'] == widget.nomeProjeto,
            orElse: () => null,
            );
            if (project == null){
              return Center(child: Text('Projeto não encontrado'));
            }
            else{
              return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  top: _screenHeight * .28,
                  height: _screenHeight * .60,
                  left: 0,
                  right: 0,
                  child: PageView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  right: 15,
                                ),
                                child: Text(
                                  project['titulo'], // Título do projeto do backend
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _buildSectionTitle("Sobre o projeto"),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  project['bjetivo'], // Descrição do projeto do backend
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              _buildSectionTitle("Membros"),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                ),
                                child: Column(
                                  children: (project['membros'] as List<dynamic>)
                                      .map((membro) => Text(
                                            membro,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              _buildSectionTitle("Outras infos"),
                              // Adicione outras seções conforme necessário
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      project['imagem'], // URL da imagem do backend
                      height: _screenHeight * .3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
            }
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}