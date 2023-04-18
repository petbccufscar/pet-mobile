import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:pet_mobile/widgets/ballon.dart";
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

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
  bool readMoreObj = false;
  bool readMoreMem = false;
  bool readMoreMeet = false;
  bool readMoreTsk = false;

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
      dense: true,
      contentPadding: EdgeInsets.all(0),
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
    return (Text(
      meets[index],
      style: const TextStyle(fontSize: 18, fontFamily: "Comfortaa"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Variável para manipulação da altura de widgets baseada na altura da tela
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text(AppLocalizations.of(context)!.mural_page_title),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: SingleChildScrollView(
          child: Column(
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
                        Flexible(
                          flex: 2,
                          child: BallonContainer(
                              onTap: () {
                                setState(() {
                                  readMoreObj = !readMoreObj;
                                });
                              },
                              backGroundColor: Color(0xFFFBAB48),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              title: "Objetivos",
                              child: Text(goal,
                                  maxLines: readMoreObj ? null : 3,
                                  overflow: readMoreObj
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: "Comfortaa")),
                              readMore: readMoreObj,
                              cndLeiaMais: goal.length > 65),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: BallonContainer(
                              onTap: () {
                                setState(() {
                                  readMoreMem = !readMoreMem;
                                });
                              },
                              backGroundColor: Color(0xFFC48BDC),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              cndLeiaMais: members.length > 4,
                              readMore: readMoreMem,
                              title: 'Membros',
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: readMoreMem
                                      ? members.length
                                      : (members.length < 3
                                          ? members.length
                                          : 3),
                                  itemBuilder: lMemberBuilder),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: _paddingColumn),
                      child: BallonContainer(
                        backGroundColor: Color(0xFFF0766B),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        cndLeiaMais: meets.length > 4,
                        onTap: () {
                          setState(() {
                            readMoreMeet = !readMoreMeet;
                          });
                        },
                        readMore: readMoreMeet,
                        title: 'Próximas Reuniões',
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: readMoreMeet
                              ? meets.length
                              : (meets.length < 3 ? meets.length : 3),
                          itemBuilder: lMeetsBuilder,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: _paddingColumn),
                      child: BallonContainer(
                        backGroundColor: Color(0xFF61CFD7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        cndLeiaMais: _toDo.length > 4,
                        onTap: () {
                          setState(() {
                            readMoreTsk = !readMoreTsk;
                          });
                        },
                        readMore: readMoreTsk,
                        title: 'Tarefas',
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: listBuilder,
                          itemCount: readMoreTsk
                              ? _toDo.length
                              : (_toDo.length < 3 ? _toDo.length : 3),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
