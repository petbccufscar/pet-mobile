import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_editing_page.dart';
import '../provider/event_provider.dart';
import '../model/event.dart';
import '../utils.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, event),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(event),
            SizedBox(
              height: 32,
            ),
            Text(
              event.getTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              event.getDescription,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      );

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.getIsAllDay ? 'Dia todo' : 'De', event.getFrom),
        if (!event.getIsAllDay) buildDate('Até', event.getTo),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            Utils.toFullDate(date),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) => [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => EventEditingPage(
                event: event,
              ),
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final provider =
                  Provider.of<EventProvider>(context, listen: false);

              provider.deleteEvent(event);
            }),
      ];
}
