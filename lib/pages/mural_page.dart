import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:pet_mobile/widgets/ballon.dart";
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';
import 'package:pet_mobile/provider/api_service.dart';

class MuralProjeto extends StatefulWidget {
  final dynamic project;

  const MuralProjeto({Key? key, this.project}) : super(key: key);

  @override
  _MuralProjetoState createState() => _MuralProjetoState();
}

class _MuralProjetoState extends State<MuralProjeto> {
  bool readMoreObj = false;
  bool readMoreMem = false;
  bool readMoreMeet = false;
  bool readMoreTsk = false;

  List<dynamic> memberNames = [];
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
        memberNames = memberDetails.map((member) => member['nome']).toList();
      });
    } catch (error) {
      print('Failed to load member details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String projectName = widget.project?['titulo'] ?? "Título do Projeto";
    String goal = widget.project?['objetivo'] ?? "Objetivo do Projeto";

    List<String> meets = ["Setembro, 15 - 16h30"];
    final List _toDo = [
      {"Title": "Desenvolver telas", "finished": false},
    ];

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
                              cndLeiaMais: memberNames.length > 4,
                              readMore: readMoreMem,
                              title: 'Membros',
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: readMoreMem
                                      ? memberNames.length
                                      : (memberNames.length < 3
                                          ? memberNames.length
                                          : 3),
                                  itemBuilder: (context, index) {
                                    return Text(
                                      memberNames[index],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Comfortaa"),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                          itemBuilder: (context, index) {
                            return Text(
                              meets[index],
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: "Comfortaa"),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              dense: true,
                              contentPadding: EdgeInsets.all(0),
                              value: _toDo[index]["finished"],
                              onChanged: (c) {
                                setState(() {
                                  _toDo[index]["finished"] = c;
                                });
                              },
                              title: Text(_toDo[index]["Title"],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Comfortaa")),
                            );
                          },
                          itemCount: readMoreTsk
                              ? _toDo.length
                              : (_toDo.length < 3 ? _toDo.length : 3),
                        ),
                      ),
                    ),
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