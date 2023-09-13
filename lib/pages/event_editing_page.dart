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
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextInput(
                  hint: 'Adicionar Título',
                  controller: titleController,
                  validator: (title) => title != null && title.isEmpty
                      ? 'Título não pode ser vazio'
                      : null,
                ),
                SizedBox(
                  height: 16.0,
                ),
                _buildDateTimeInput(
                    headerText: 'Começo',
                    date: fromDate,
                    onDateClicked: () => _pickFromDateTime(pickDate: true),
                    onTimeClicked: () => _pickFromDateTime(pickDate: false)),
                SizedBox(
                  height: 16.0,
                ),
                _buildDateTimeInput(
                    headerText: 'Fim',
                    date: toDate,
                    onDateClicked: () => _pickToDateTime(pickDate: true),
                    onTimeClicked: () => _pickToDateTime(pickDate: false)),
                SizedBox(
                  height: 16.0,
                ),
                _buildTextInput(
                    hint: 'Descrição',
                    controller: descriptionController,
                    validator: null),
                SizedBox(
                  height: 16.0,
                ),
                _buildIsAllDay(),
                SizedBox(
                  height: 16.0,
                ),
                _buildActionButton(
                    title: 'Salvar', icon: Icons.done, onPressed: _saveForm),
                SizedBox(
                  height: 16.0,
                ),
                widget.event != null
                    ? _buildActionButton(
                        title: 'Excluir',
                        icon: Icons.delete,
                        onPressed: _deleteAppointment,
                        buttonColor: Colors.red)
                    : SizedBox()
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

  Widget _buildHeader({
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

  Widget _buildTextInput(
          {required String hint,
          required TextEditingController controller,
          required String? Function(String?)? validator}) =>
      TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: hint,
        ),
        onFieldSubmitted: (_) => _saveForm(),
        validator: validator,
        controller: controller,
      );

  Widget _buildDateTimeInput(
          {required String headerText,
          required DateTime date,
          required VoidCallback onDateClicked,
          required VoidCallback onTimeClicked}) =>
      _buildHeader(
        header: headerText,
        child: Row(
          children: [
            Expanded(
              flex: 2, // Faz o pegar 66% da tela
              child: _buildDropdownField(
                text: Utils.toFullDate(date),
                onClicked: onDateClicked,
              ),
            ),
            isAllDayMark
                ? SizedBox()
                : Expanded(
                    flex: 1,
                    child: _buildDropdownField(
                      text: Utils.toTime(date),
                      onClicked: onTimeClicked,
                    ),
                  )
          ],
        ),
      );

  Widget _buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget _buildIsAllDay() => Row(
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

  Future _pickFromDateTime({required bool pickDate}) async {
    final date = await _pickDateTime(
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

  Future _pickToDateTime({required bool pickDate}) async {
    final date = await _pickDateTime(
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

  Future<DateTime?> _pickDateTime(
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

  Widget _buildActionButton(
      {required String title,
      required IconData icon,
      required void Function() onPressed,
      Color? buttonColor}) {
    return SizedBox(
      height: 56,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }

  Future _saveForm() async {
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

  Future _deleteAppointment() async {
    final isEditing = widget.event != null;
    final provider = Provider.of<EventProvider>(context, listen: false);

    if (isEditing) {
      provider.deleteEvent(widget.event!);
      Navigator.of(context).pop();
    }
  }
}
