import 'package:flutter/material.dart';
import 'package:pet_mobile/provider/api_service.dart';

class ActivityDescriptionPage extends StatefulWidget {
  final Map<String, dynamic> activity;

  ActivityDescriptionPage({Key? key, required this.activity}) : super(key: key);

  @override
  _ActivityDescriptionPageState createState() => _ActivityDescriptionPageState();
}

class _ActivityDescriptionPageState extends State<ActivityDescriptionPage> {
  late ApiService apiServicePerfis; // ApiService para detalhes dos membros
  late ApiService apiServiceProjetos; // ApiService para detalhes do projeto

  List<String> memberNames = [];
  String projectName = '';

  @override
  void initState() {
    super.initState();
    apiServicePerfis = ApiService(UrlAppend: 'perfis/'); // Inicializa ApiService para detalhes dos membros
    apiServiceProjetos = ApiService(UrlAppend: 'projetos/'); // Inicializa ApiService para detalhes do projeto
    fetchDetails();
  }

  void fetchDetails() async {
    try {
      // Busca nomes dos membros
      final memberIds = widget.activity['membros'].cast<int>();
      final memberDetails = await apiServicePerfis.fetchMemberDetails(memberIds);
      setState(() {
        memberNames = memberDetails.map((member) => member['nome'].toString()).toList();
      });

      // Busca nome do projeto usando o ID do projeto
      final projectId = widget.activity['projeto'];
      final projectDetails = await apiServiceProjetos.fetchDataById(projectId);
      setState(() {
        projectName = projectDetails['titulo'].toString();
      });
    } catch (error) {
      print('Failed to load details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActivityDetail('Título', widget.activity['titulo'] ?? 'Título não disponível'),
            _buildActivityDetail('Descrição', widget.activity['descricao'] ?? 'Descrição não disponível'),
            _buildActivityDetail('Data', widget.activity['data'] ?? 'Data não disponível'),
            _buildActivityDetail('Duração', widget.activity['tempo'] ?? 'Duração não disponível'),
            _buildActivityDetail('Membros', _formatMembers()),
            _buildActivityDetail('Projeto', projectName.isNotEmpty ? projectName : 'Projeto não disponível'),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityDetail(String title, String value) {
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
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  String _formatMembers() {
    if (memberNames.isEmpty) {
      return 'Carregando membros...'; // Pode ser útil mostrar um indicador enquanto carrega
    }
    return memberNames.join(', ');
  }
}