import 'package:flutter/material.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';
import 'package:intl/intl.dart';

class MeetPage extends StatefulWidget {
  @override
  _MeetPageState createState() => _MeetPageState();
}

class _MeetPageState extends State<MeetPage> {
  final dropValue = ValueNotifier('');
  final dropOptions = ['Software Quântico', 'PET Mobile', 'Marketing'];

  final _members = ['Augusto', 'Bruno', 'Caio'];
  List<String> _selectedMemb = [];

  TextEditingController dateController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuScaffoldWithProfileHeader(
      appBarTitle: Text('Marcar Reunião'),
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
                          hintText: "Assunto",
                          prefixIcon: Icon(Icons.subject)),
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
                          hintText: "Descrição",
                          prefixIcon: Icon(Icons.description)),
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
                          hintText: "Link Reunião",
                          prefixIcon: Icon(Icons.link)),
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      controller: dateController,
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 15),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Data",
                          prefixIcon: Icon(Icons.calendar_today)),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat("dd/MM/yyyy").format(pickedDate);

                          setState(() {
                            dateController.text = formattedDate.toString();
                          });
                        } else {
                          print("Not selected");
                        }
                      },
                    ))),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    style:
                        const TextStyle(fontFamily: "Montserrat", fontSize: 15),
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    //controller: descricao,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Horário',
                        prefixIcon: Icon(Icons.access_time_outlined)),
                    onTap: () async {
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );

                      if (selectedTime != null) {
                        setState(() {
                          _selectedTime = selectedTime;
                        });
                      }
                    },
                    controller: TextEditingController(
                        text: _selectedTime.format(context)),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                    color: Colors.transparent,
                    child: ValueListenableBuilder(
                        valueListenable: dropValue,
                        builder: (BuildContext context, String value, _) {
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Selecione o Projeto',
                                hintStyle: TextStyle(
                                    fontFamily: "Montserrat", fontSize: 15)),
                            value: (value.isEmpty) ? null : value,
                            onChanged: (escolha) =>
                                dropValue.value = escolha.toString(),
                            items: dropOptions
                                .map((op) => DropdownMenuItem(
                                      value: op,
                                      child: Text(op),
                                    ))
                                .toList(),
                          );
                        }))),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text('Pronto'),
                    style: TextButton.styleFrom(
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    onPressed: () {},
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//Antigos inputs

// class _MeetPageState extends State<MeetPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SideMenuScaffold(
//       appBarTitle: Text('Meet Page'),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             CustomTextField(hint: 'Assunto...', icon: Icons.subject),
//             SizedBox(height: 15),
//             CustomTextField(hint: 'Descrição...', icon: Icons.description),
//             SizedBox(height: 15),
//             CustomTextField(
//                 hint: 'Data...', icon: Icons.calendar_today_outlined),
//             SizedBox(height: 15),
//             ElevatedButton(
//               onPressed: () {
//                 createAlertDialog(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.access_time, color: Colors.white70),
//                   Text("  Horário"),
//                 ],
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.all(18),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 textStyle: TextStyle(color: Colors.white),
//               ),
//             ),
//             // CustomTextField(hint: 'Horário...', icon: Icons.access_time),
//             SizedBox(height: 15),
//             CustomTextField(
//                 hint: 'Membros Participantes...', icon: Icons.person),
//             SizedBox(height: 15),
//             CustomTextField(hint: 'Link Reunião...', icon: Icons.link),
//             SizedBox(height: 15),
//             CustomTextField(hint: 'Anexar...', icon: Icons.attach_file),
//           ]),
//         ),
//       ),
//     );
//   }
// }

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
