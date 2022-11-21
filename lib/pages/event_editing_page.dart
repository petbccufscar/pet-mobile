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
      final provider = Provider.of<EventProvider>(context, listen: false);
      final now = DateTime.now();
      final timeFrom;
      final timeTo;

      if (now.day != provider.selectedDate.day) {
        timeFrom = Duration(hours: provider.selectedDate.hour + 8);
        timeTo = Duration(hours: provider.selectedDate.hour + 10);
      } else {
        timeFrom = Duration(hours: now.hour, minutes: now.minute);
        timeTo = Duration(hours: now.hour + 2, minutes: now.minute);
      }

      fromDate = provider.selectedDate.add(timeFrom);
      toDate = provider.selectedDate.add(timeTo);
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      currentColor = event.backgroundColor;
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
                buildTextInput(
                  hint: 'Adicionar Título',
                  controller: titleController,
                  validator: (title) => title != null && title.isEmpty
                      ? 'Título não pode ser vazio'
                      : null,
                ),
                buildDateTimeInput(
                    headerText: 'Começo',
                    date: fromDate,
                    onDateClicked: () => pickFromDateTime(pickDate: true),
                    onTimeClicked: () => pickFromDateTime(pickDate: false)),
                buildDateTimeInput(
                    headerText: 'Fim',
                    date: toDate,
                    onDateClicked: () => pickToDateTime(pickDate: true),
                    onTimeClicked: () => pickToDateTime(pickDate: false)),
                buildTextInput(
                    hint: 'Descrição',
                    controller: descriptionController,
                    validator: null),
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
            shadowColor: Colors.transparent,
          ),
          onPressed: saveForm,
          icon: Icon(Icons.done),
          label: Text('Salvar'),
        ),
      ];

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

  Widget buildTextInput(
          {required String hint,
          required TextEditingController controller,
          required String? Function(String?)? validator}) =>
      TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: hint,
        ),
        onFieldSubmitted: (_) => saveForm(),
        validator: validator,
        controller: controller,
      );

  Widget buildDateTimeInput(
          {required String headerText,
          required DateTime date,
          required VoidCallback onDateClicked,
          required VoidCallback onTimeClicked}) =>
      buildHeader(
        header: headerText,
        child: Row(
          children: [
            Expanded(
              flex: 2, // Faz o pegar 66% da tela
              child: buildDropdownField(
                text: Utils.toFullDate(date),
                onClicked: onDateClicked,
              ),
            ),
            isAllDayMark
                ? SizedBox()
                : Expanded(
                    child: buildDropdownField(
                      text: Utils.toTime(date),
                      onClicked: onTimeClicked,
                    ),
                  )
          ],
        ),
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

                if (isAllDayMark) {
                  DateTime now = DateTime.now();
                  var allDayDate = DateTime(now.year, now.month, now.day);

                  fromDate = allDayDate;
                  toDate = allDayDate;
                }
              });
            },
          ), //Checkbox
        ], //<Widget>[]
      );

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
