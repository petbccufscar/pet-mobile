import "package:flutter/material.dart";
import 'package:pet_mobile/widgets/side_menu_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MuralProjeto extends StatefulWidget {
  const MuralProjeto({Key? key}) : super(key: key);

  @override
  _MuralProjetoState createState() => _MuralProjetoState();
}

class _MuralProjetoState extends State<MuralProjeto> {
  String projectName = "PET MOBILE";
  String goal = "Criar um aplicativo mobile para auxiliar grupos PET.";
  List members = [
    "Amanda",
    "Allan",
    "Bruno",
    "Carlos",
    "Iara",
    "Lorenzo",
    "Matheus",
  ];

  // Próximas reuniões.
  List<String> meets = ["Setembro, 15 - 16h30"];

  // Tarefas a serem feitas.
  final List _toDo = [
    {"Title": "Desenvolver telas", "finished": false},
  ];

  // Controla o padding da coluna dentro do corpo do Scaffold.
  static const double _paddingColumn = 15;

  Widget listBuilder(BuildContext context, int index) {
    return CheckboxListTile(
      value: _toDo[index]["finished"],
      onChanged: (c) {
        setState(
          () {
            _toDo[index]["finished"] = c;
          },
        );
      },
      title: Text(
        _toDo[index]["Title"],
        style: const TextStyle(fontFamily: "Comfortaa", fontSize: 18),
      ),
    );
  }

  Widget lMemberBuilder(BuildContext context, int index) {
    return (Text(
      members[index],
      style: const TextStyle(fontSize: 18, fontFamily: "Comfortaa"),
    ));
  }

  Widget lMeetsBuilder(BuildContext context, int index) {
    return (Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Text(
        meets[index],
        style: const TextStyle(fontSize: 18, fontFamily: "Comfortaa"),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Variável para manipulação da altura de widgets baseada na altura da tela
    double _scrnH = MediaQuery.of(context).size.height;
    return SideMenuScaffold(
      appBarTitle: Text(AppLocalizations.of(context)!.mural_page_title),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: ListView(
          children: [
            Text(
              projectName,
              style: const TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFFBAB48),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.only(
                                    top: 5, start: 10),
                                child: Text(
                                  "Objetivos",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 5, start: 10),
                                child: Text(
                                  goal,
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: "Comfortaa"),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Container(
                            //height: members.isEmpty ? null : _scrnH / 5,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Color(0xFFC48BDC),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      top: 5, start: 10),
                                  child: Text(
                                    "Membros",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 5, start: 10),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: members.length,
                                        itemBuilder: lMemberBuilder)),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _paddingColumn),
                    child: Container(
                      height: _scrnH / 4,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0766B),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 5, start: 10, bottom: 10),
                            child: Text(
                              "Próximas Reuniões",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: meets.length,
                              itemBuilder: lMeetsBuilder,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _paddingColumn),
                    child: Container(
                      height: _scrnH / 4,
                      decoration: const BoxDecoration(
                          color: Color(0xFF61CFD7),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.only(top: 5, start: 10),
                            child: Text(
                              "Tarefas",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: listBuilder,
                              itemCount: _toDo.length,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
