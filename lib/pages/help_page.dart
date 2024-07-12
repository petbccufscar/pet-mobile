import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';
import 'package:pet_mobile/provider/api_service.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late Future<List<dynamic>> futureHelpInfo;
  final ApiService apiService = ApiService(UrlAppend: 'ajuda/'); // Ajuste o endpoint conforme necessário

  @override
  void initState() {
    super.initState();
    futureHelpInfo = apiService.fetchData();
  }

  final String email = 'petbcc@ufscar.br';

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text(AppLocalizations.of(context)!.help_page_title),
      body: Container(
        color: Color(0xFFDFECEB),
        child: Column(
          children: [
            // Lista com os cards de ajuda
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: futureHelpInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<_HelpInfo> helpInfoList = snapshot.data!.map<_HelpInfo>((item) {
                      return _HelpInfo(item['titulo'], item['descricao']);
                    }).toList();

                    return ListView.separated(
                      separatorBuilder: (BuildContext ctx, int index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: helpInfoList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: index == 0 ? 20 : 0,
                            left: 20,
                            right: 20,
                            bottom: index == helpInfoList.length - 1
                                ? MediaQuery.of(context).size.height * 0.5
                                : 0,
                          ),
                          child: ExpansionTile(
                            collapsedBackgroundColor: Color(0xFFF4F4F4),
                            backgroundColor: Color(0xFFF4F4F4),
                            title: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RichText(
                                text: TextSpan(
                                  text: helpInfoList[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    text: helpInfoList[index].info,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            // Texto "Fale conosco: petbcc@ufscar.br" como um link azul
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: email));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('E-mail copiado para a área de transferência')),
                  );
                },
                child: Text(
                  'Fale conosco: $email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpInfo {
  _HelpInfo(this.title, this.info);

  final String title;
  final String info;
}
