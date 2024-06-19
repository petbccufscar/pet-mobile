import 'package:flutter/material.dart';
//import 'package:pet_mobile/pages/meet_page.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';
import 'package:pet_mobile/pages/marcar_atividades.dart';
import 'package:pet_mobile/pages/activity_description.dart';
import 'package:pet_mobile/provider/api_service.dart'; 

class Atividade extends StatefulWidget {
  const Atividade({Key? key}) : super(key: key);

  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<Atividade> {
  late Future<List<dynamic>> futureActivities;
  final ApiService apiService = ApiService(UrlAppend: 'atividades/'); // Ajuste o endpoint conforme necessário

  @override
  void initState() {
    super.initState();
    futureActivities = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text('Atividades'),
      body: Stack(
        children: [
          Positioned(
            top: 5,
            bottom: 50,
            left: 0,
            right: 0,
            child: FutureBuilder<List<dynamic>>(
              future: futureActivities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhuma atividade encontrada'));
                } else {
                  List<dynamic> atividades = snapshot.data!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: atividades.map((atividade) {
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ActivityDescriptionPage(activity: {}),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "${atividade['titulo']}", // Ajuste conforme os campos retornados pelo backend
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarcarAtividadePage()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: 'Adicionar atividade',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
