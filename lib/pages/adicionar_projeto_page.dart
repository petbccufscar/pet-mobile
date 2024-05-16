import 'package:flutter/material.dart';
import "package:pet_mobile/utils.dart";
import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';

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
  late DateTime toDate;
  late DateTime fromDate;
  List _members = [];

  @override
  void initState() {
    super.initState();
    fromDate = DateTime.now();
    toDate = DateTime.now().add(Duration(days: 730));
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8), // Range de escolha de data
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time = Duration(
        hours: initialDate.hour,
        minutes: initialDate.minute,
      );

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;

      final date = DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      );

      final time = Duration(
        hours: timeOfDay.hour,
        minutes: timeOfDay.minute,
      );

      return date.add(time);
    }
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      fromDate,
      pickDate: pickDate,
    );

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate = DateTime(
        date.year,
        date.month,
        date.day,
        (fromDate.hour + 2),
        fromDate.minute,
      );
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );

    if (date == null) return;

    /*
    Faz com que seja possivel selecionar uma data final (toDate) que é
    anterior a data inicial(fromDate), mas ao fazer isso a data inicial vira a
    data final -2 horas #TODO Escolher como implementar isso depois.
    if (date.isBefore(fromDate)) {
      fromDate = DateTime(
          date.year, date.month, date.day, (toDate.hour - 2), fromDate.minute);
    }
    */
    setState(() => toDate = date);
  }

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(color: Colors.grey),
          ),
          child,
        ],
      );

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildDateTimePickes() => Column(
        children: [buildFrom(), buildTo()],
      );

  Widget buildFrom() => buildHeader(
        header: 'Data de início',
        child: buildDropdownField(
          text: Utils.toFullDate(fromDate),
          onClicked: () => pickFromDateTime(pickDate: true),
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'Data de fim',
        child: buildDropdownField(
          text: Utils.toFullDate(toDate),
          onClicked: () => pickToDateTime(pickDate: true),
        ),
      );

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
    return SideMenuScaffoldWithProfileHeader(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                          padding: EdgeInsets.only(
                            left: 5,
                            top: 10,
                          ),
                          color: Colors.white,
                          child: buildDateTimePickes()),
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: "Data de início",
                    //       hintStyle: TextStyle(color: Color(0xFF989898)),
                    //       fillColor: Color(0xFFFFFFFF),
                    //       filled: true),
                    // ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: "Data de fim",
                    //       hintStyle: TextStyle(color: Color(0xFF989898)),
                    //       fillColor: Color(0xFFFFFFFF),
                    //       filled: true),
                    // ),
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
                                // Adiciona o membro ao apertar ENTER.
                                onFieldSubmitted: (membro) {
                                  _novoMembro.text = membro;
                                  setState(
                                    () {
                                      if (_novoMembro.text.isNotEmpty)
                                        _members.add(_novoMembro.text);
                                      _novoMembro.text = "";
                                    },
                                  );
                                },
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
