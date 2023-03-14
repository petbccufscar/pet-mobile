import 'package:flutter/material.dart';

class DescricaoProjeto extends StatefulWidget {
  const DescricaoProjeto({Key? key}) : super(key: key);

  @override
  State<DescricaoProjeto> createState() => _DescricaoProjetoState();
}

class _DescricaoProjetoState extends State<DescricaoProjeto> {
  final List<String> _membros = [
    "Fulano",
    "Ciclano",
    "Beltrano"
  ]; // adicionando membros

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Descrição do projeto"),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: _screenHeight * .28,
            height: _screenHeight * .60,
            left: 0,
            right: 0,
            child: PageView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            top: 10,
                            right: 15,
                          ),
                          child: const Text(
                            "Engenharia de Software Quântico",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildSectionTitle("Sobre o projeto"),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            right: 10,
                          ),
                          child: Text(
                            "Desenvolvimento de softwares da computação clássica em computação quântica para testes e comparações de benchmark, afim de atestar com valores os ganhos significativos de performance e de tempo.",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        _buildSectionTitle("Membros"),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                          ),
                          child: Column(
                            children: _membros
                                .map((membro) => Text(
                                      membro,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        _buildSectionTitle("Outras infos"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -10,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.network(
                "https://socientifica.com.br/wp-content/uploads/2019/12/Computa%C3%A7%C3%A3o-quantica-scaled.png?ezimgfmt=ngcb4/notWebP",
                height: _screenHeight * .3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
