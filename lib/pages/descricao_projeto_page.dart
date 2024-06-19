import 'package:flutter/material.dart';
import 'package:pet_mobile/provider/api_service.dart';

class DescricaoProjeto extends StatefulWidget {
  final dynamic project;

  const DescricaoProjeto({Key? key, required this.project}) : super(key: key);

  @override
  State<DescricaoProjeto> createState() => _DescricaoProjetoState();
}

class _DescricaoProjetoState extends State<DescricaoProjeto> {
  List<String> memberNames = []; // Inicialize como List<String>
  final ApiService apiService = ApiService(UrlAppend: 'perfis/');

  @override
  void initState() {
    super.initState();
    fetchMemberNames();
  }

  void fetchMemberNames() async {
    try {
      final memberIds = widget.project['membros'].cast<int>();
      final memberDetails = await apiService.fetchMemberDetails(memberIds);
      setState(() {
        memberNames = memberDetails.map((member) => member['nome'].toString()).toList();
        // Use toString() para garantir que o nome seja convertido para String
      });
    } catch (error) {
      print('Failed to load member details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    final project = widget.project;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Descrição do projeto"),
        centerTitle: true,
      ),
      body: Stack(
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
                            project['objetivo'], // Descrição do projeto do backend
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
                            children: memberNames
                                .map((nome) => Text(
                                      nome,
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