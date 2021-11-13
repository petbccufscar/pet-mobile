import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../provider/event_provider.dart';
import '../model/event_data_source.dart';
import '../widgets/tasks_widget.dart';
import '../pages/event_editing_page.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarController _calendarController = CalendarController();

  @override
  initState() {
    _calendarController.view = CalendarView.week;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_view_month),
            onPressed: () {
              _calendarController.view = CalendarView.month;
            },
          ),
          IconButton(
            icon: Icon(Icons.view_week),
            onPressed: () {
              _calendarController.view = CalendarView.week;
            },
          ),
          IconButton(
            icon: Icon(Icons.view_day),
            onPressed: () {
              _calendarController.view = CalendarView.day;
            },
          ),
        ],
      ),
      body: Container(
        child: SfCalendar(
          headerHeight: 0,
          controller: _calendarController,
          dataSource: EventDataSource(events),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          onLongPress: (details) {
            final provider = Provider.of<EventProvider>(
              context,
              listen: false,
            );

            provider.setDate(details.date!);
            showModalBottomSheet(
              context: context,
              builder: (context) => TasksWidget(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventEditingPage(),
          ),
        ),
      ),
    );
  }
}