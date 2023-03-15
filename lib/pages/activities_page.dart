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
            ElevatedButton(
              onPressed: (){
                //acessa a atividade
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Atividade Modelo 4"),
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
                  Text("Atividade Modelo 5"),
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
                  Text("Atividade Modelo 6"),
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
                  Text("Atividade Modelo 7"),
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
                  Text("Atividade Modelo 8"),
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
                  Text("Atividade Modelo 9"),
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
                  Text("Atividade Modelo 10"),
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
                  Text("Atividade Modelo 11"),
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
            Align(
              alignment: Alignment.bottomCenter,
              /*
                child: ElevatedButton(
                  onPressed: () {
                    //ver mais
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                  ),
                  child: Text('ver mais',
                style: TextStyle(color: Colors.blue),
                  ),
                )
                  */
              child: Text('ver mais',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text('marcar atividade',
                style: TextStyle(color: Colors.blue),
              ),
            )
            /*
              PlaceHolders Apenas para visualização de como ficará
              CustomTextField(hint: 'Atividade PlaceHolder01'),
              SizedBox(height: 15),
              CustomTextField(hint: 'Atividade PlaceHolder03'),
              SizedBox(height: 15),
              CustomTextField(hint: 'Atividade PlaceHolder04'),
              SizedBox(height: 15),
              CustomTextField(hint: 'Atividade PlaceHolder05'),
              SizedBox(height: 15),
               */
          ]),
        ),
      ),
    );
  }
}