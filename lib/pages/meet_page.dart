import 'package:flutter/material.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold.dart';

class MeetPage extends StatefulWidget {
  @override
  _MeetPageState createState() => _MeetPageState();
}

class _MeetPageState extends State<MeetPage> {
  @override
  Widget build(BuildContext context) {
    return SideMenuScaffold(
      appBarTitle: Text('Meet Page'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomTextField(hint: 'Assunto...', icon: Icons.subject),
            SizedBox(height: 15),
            CustomTextField(hint: 'Descrição...', icon: Icons.description),
            SizedBox(height: 15),
            CustomTextField(
                hint: 'Data...', icon: Icons.calendar_today_outlined),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                createAlertDialog(context);
              },
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white70),
                  Text("  Horário"),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            // CustomTextField(hint: 'Horário...', icon: Icons.access_time),
            SizedBox(height: 15),
            CustomTextField(
                hint: 'Membros Participantes...', icon: Icons.person),
            SizedBox(height: 15),
            CustomTextField(hint: 'Link Reunião...', icon: Icons.link),
            SizedBox(height: 15),
            CustomTextField(hint: 'Anexar...', icon: Icons.attach_file),
          ]),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;

  const CustomTextField({Key? key, required this.hint, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white70),
        prefixIcon: icon == null ? null : Icon(icon, color: Colors.white70),
        fillColor: Colors.blue,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

createAlertDialog(BuildContext context) {
  TextEditingController customeController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Escreva aqui"),
            content: TextField(
              controller: customeController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(customeController.text.toString());
                },
              )
            ]);
      });
}
