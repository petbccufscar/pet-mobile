import 'package:flutter/material.dart';
//import 'package:pet_mobile/pages/meet_page.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

//atividades serão puxadas do B.D.
List<int> atividades = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

class Atividade extends StatelessWidget {
  const Atividade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text('Atividades'),
      body: Stack(
        children: [
        Positioned(
          top: 5,
          bottom: 100,
          left:0, right:0,
          child: SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: atividades.map((atividades){
                    return ElevatedButton(onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text("Atividade $atividades",
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
                    );
                  }).toList(),
              ),
            ),
          ),
        ),
          Positioned(
            bottom: 50,
            left:0, right:0,
            height: 50,
            child: TextButton(
                onPressed: () {},
                child: Text.rich(
                    TextSpan(
                      text: 'Ver mais atividade',
                      style: TextStyle(color: Colors.blue),
                    )
                )
            ),
          ),
          Positioned(
            bottom: 0,
            left:0, right:0,
            height: 50,
            child: TextButton(

                onPressed: () {},
                child: Text.rich(
                    TextSpan(
                      text: 'Adicionar atividade',
                      style: TextStyle(color: Colors.blue),
                    )
                )
            ),
          ),
      ],
      ),
    );
  }
}