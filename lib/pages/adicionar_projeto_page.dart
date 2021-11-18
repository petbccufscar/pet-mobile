import 'package:flutter/material.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold.dart';

class AdicionarProjeto extends StatefulWidget {
  const AdicionarProjeto({Key? key}) : super(key: key);

  @override
  _AdicionarProjetoState createState() => _AdicionarProjetoState();
}

class _AdicionarProjetoState extends State<AdicionarProjeto> {
  @override
  Widget build(BuildContext context) {
    return SideMenuScaffold(
      appBarTitle: Text("Adicionar Projeto"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF1485BF),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                CircleAvatar(
                  maxRadius: 64,
                  backgroundColor: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Adicionar foto.",
                      style: TextStyle(
                          color: Color(0xFFCFFFD7),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                ),
                Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nome do projeto",
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Área do projeto",
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Breve descrição",
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Data de início",
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Data de fim",
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
