import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginTela createState() => LoginTela();
}

class LoginTela extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://cdnstatic8.com/emporiodoeva.com.br/wp-content/uploads/2017/02/eva-azul-beb%C3%AA.jpg"))),
            ),
            //SizedBox(
            //width: 200,
            //height: 200,
            //child: Image.asset("assets/icone.jpeg"),
            //),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Container(
                height: 50.0,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: Text(
                    "entrar",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(160, 5, 100, 5),
              child: Text(
                "ou",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Container(
                height: 50.0,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: Text(
                    "conectar com facebook",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Container(
                height: 50.0,
                child: TextButton(
                    onPressed: () {},
                    child: Text.rich(
                      TextSpan(
                        text: 'Não tem uma conta? ',
                        style: TextStyle(fontSize: 13),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Cadastre-se!',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
