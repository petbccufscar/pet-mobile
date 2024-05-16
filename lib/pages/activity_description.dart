import 'package:flutter/material.dart';

class ActivityDescriptionPage extends StatelessWidget {
  const ActivityDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String sampleActivity = "Reunião de Planejamento;Reunião para discutir o planejamento do projeto;2024-04-15;2 horas;João, Maria, Pedro;Projeto XYZ";
    List<String> activityInfo = sampleActivity.split(';'); // Divide a string em partes usando o delimitador ';'

    return Scaffold(
      appBar: AppBar(
        title: Text('Atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activityInfo[0]), // Título da atividade
            SizedBox(height: 20),
            Text(
              'Descrição',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activityInfo[1]), // Descrição da atividade
            SizedBox(height: 20),
            Text(
              'Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activityInfo[2]), // Data da atividade
            SizedBox(height: 20),
            Text(
              'Duração',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activityInfo[3]), // Duração da atividade
            SizedBox(height: 20),
            Text(
              'Membros',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activityInfo[4]), // Membros da atividade
            SizedBox(height: 20),
            Text(
              'Projeto',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(activityInfo[5]), // Nome do projeto da atividade
          ],
        ),
      ),
    );
  }
}
