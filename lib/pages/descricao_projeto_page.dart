import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Descricao extends StatefulWidget {
  const Descricao({Key? key}) : super(key: key);

  @override
  State<Descricao> createState() => _DescricaoState();
}

class _DescricaoState extends State<Descricao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Engenharia de Software Quântico"),
        centerTitle: true,
        backgroundColor: Color(0xff0A6D92),
        leading: Icon(
          Icons.menu,  
          ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.blue
            ]
          )
        )

      ),
    );
  }
}
