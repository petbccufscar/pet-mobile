import 'package:flutter/material.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold.dart';

class AdicionarProjeto extends StatefulWidget {
  const AdicionarProjeto({Key? key}) : super(key: key);

  @override
  _AdicionarProjetoState createState() => _AdicionarProjetoState();
}

class _AdicionarProjetoState extends State<AdicionarProjeto> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeProjeto = TextEditingController();
  TextEditingController _areaProjeto = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _novoMembro = TextEditingController();

  List _members = [];

  Widget listBuildNewMembers(context, index) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  setState(
                    () {
                      _members.removeAt(index);
                    },
                  );
                },
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red.shade400,
                ),
              ),
            ),
            Text(
              _members[index],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffold(
      appBarTitle: Text("Adicionar Projeto"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF1485BF),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: ListView(
            clipBehavior: Clip.antiAlias,
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFFCFFFD7),
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomeProjeto,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nome do projeto",
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true),
                    ),
                    TextFormField(
                      controller: _areaProjeto,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Área do projeto",
                          hintStyle: TextStyle(color: Color(0xFF989898)),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true),
                    ),
                    TextFormField(
                      controller: _descricao,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _members.length,
                          itemBuilder: listBuildNewMembers),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    if (_novoMembro.text.isNotEmpty)
                                      _members.add(_novoMembro.text);
                                    _novoMembro.text = "";
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.add_circle_rounded,
                                color: Color(0xFF6CEA9E),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _novoMembro,
                                decoration: InputDecoration(
                                    hintText: "Adicionar membro",
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
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
