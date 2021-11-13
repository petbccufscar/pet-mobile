import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../model/event.dart';
import '../utils.dart';
import '../provider/event_provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  late String description;
  late bool isAllDayMark = false;
  late Color pickerColor = Color(0xff443a49);
  late Color currentColor = Color(0xff443a49);

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      isAllDayMark = event.isAllDay;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: buildEditingActions(),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildTitle(),
            buildDateTimePickes(),
            buildDescription(),
            buildIsAllDay(),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
      icon: Icon(
        Icons.palette,
        color: Colors.white,
      ),
      label: Text('Escolher Cor'),
      backgroundColor: Colors.blue,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(2.0),
              title: const Text('Escolher cor da tarefa'),
              contentPadding: const EdgeInsets.all(2.0),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Salvar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    ),
  );

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  List<Widget> buildEditingActions() => [
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: saveForm,
      icon: Icon(Icons.done),
      label: Text('Salvar'),
    ),
  ];

  Widget buildTitle() => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'Adicionar título',
    ),
    onFieldSubmitted: (_) => saveForm(),
    validator: (title) =>
    title != null && title.isEmpty ? 'Título não pode ser vazio' : null,
    controller: titleController,
  );

  Widget buildDescription() => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'Descrição',
    ),
    onFieldSubmitted: (_) => saveForm(),
    validator: null,
    controller: descriptionController,
  );

  /* Widget pickColor() => Column(
          /* header: 'Escolher Cor', */
          children: [
            Text(
              'Escolher Cor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            BlockPicker(
              pickerColor: pickedColor,
              onColorChanged: changeColor,
            ),
          ]); */

  Widget pickColor() => buildHeader(
    header: 'Escolher Cor',
    child: AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Got it'),
          onPressed: () {
            setState(() => currentColor = pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );

  Widget buildDateTimePickes() => Column(
    children: [buildFrom(), buildTo()],
  );

  Widget buildFrom() => buildHeader(
    header: 'Começo',
    child: Row(
      children: [
        Expanded(
          flex: 2, // Faz o pegar 66% da tela
          child: buildDropdownField(
            text: Utils.toDate(fromDate),
            onClicked: () => pickFromDateTime(pickDate: true),
          ),
        ),
        Expanded(
          child: buildDropdownField(
            text: Utils.toTime(fromDate),
            onClicked: () => pickFromDateTime(pickDate: false),
          ),
        ),
      ],
    ),
  );

  Widget buildTo() => buildHeader(
      header: 'Fim',
      child: Row(
        children: [
          Expanded(
            flex: 2, // Faz o pegar 66% da tela
            child: buildDropdownField(
              text: Utils.toDate(toDate),
              onClicked: () => pickToDateTime(pickDate: true),
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Utils.toTime(toDate),
              onClicked: () => pickToDateTime(pickDate: false),
            ),
          )
        ],
      ));

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

  Widget buildIsAllDay() => Row(
    children: <Widget>[
      SizedBox(
        width: 10,
      ), //SizedBox
      Text(
        'Evento é o dia todo: ',
        style: TextStyle(fontSize: 17.0),
      ), //Text
      SizedBox(width: 10), //SizedBox
      /** Checkbox Widget **/
      Checkbox(
        value: isAllDayMark,
        onChanged: (value) {
          setState(() {
            isAllDayMark = value as bool;
          });
        },
      ), //Checkbox
    ], //<Widget>[]
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

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child,
        ],
      );

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
        title: titleController.text,
        description: descriptionController.text,
        from: fromDate,
        to: toDate,
        isAllDay: isAllDayMark,
        backgroundColor: currentColor,
      );

      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);
        Navigator.of(context).pop();
      } else {
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }
}