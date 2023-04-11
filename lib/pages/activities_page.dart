import 'package:flutter/material.dart';
//import 'package:pet_mobile/pages/meet_page.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';


class Atividade extends StatelessWidget {
  const Atividade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text('Atividades'),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[
            //Acessa o BD e mostra todas as atividades na conta do aluno
            ElevatedButton(
              onPressed: (){
                //acessa a atividade
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Atividade Modelo 1",
                      textAlign: TextAlign.center,),
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                //acessa a atividade
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Atividade Modelo 2"),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                //acessa a atividade
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Atividade Modelo 3"),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            //Spacer(),
            Positioned(
              bottom: 0,
              child: TextButton(
                  onPressed: () {},
                  child: Text.rich(
                    TextSpan(
                      text: 'ver mais',
                      style: TextStyle(color: Colors.blue),
                    )
                  )
                ),
              ),
            Positioned(
              bottom: 0,
              child: TextButton(
                  onPressed: () {},
                  child: Text.rich(
                      TextSpan(
                        text: 'marcar atividade',
                        style: TextStyle(color: Colors.blue),
                      )
                  )
              ),
            ),
          ]),
        ),
      ),
    );
  }
}