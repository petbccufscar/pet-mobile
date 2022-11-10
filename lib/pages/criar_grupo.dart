import "package:flutter/material.dart";
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

class CriarGrupo extends StatefulWidget {
  const CriarGrupo({Key? key}) : super(key: key);

  @override
  CriarGrupoPage createState() => CriarGrupoPage();
}

class CriarGrupoPage extends State<CriarGrupo> {
  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text('Registrar Grupo'),
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 15),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Nome"),
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 15),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Instituição"),
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 15),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Curso"),
                    ))),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text('Criar'),
                    style: TextButton.styleFrom(
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    onPressed: () {},
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Checkbox(
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      value: _checkbox,
                      onChanged: (value) {
                        setState(() {
                          _checkbox = !_checkbox;
                        });
                      },
                    ),*/
                    /*Expanded(
                      child: Text(
                          'Eu concordo com os dados acima registrados, e que autorizo o uso para o processo de verificação de contas.',
                          textAlign: TextAlign.justify),
                    ),*/
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
