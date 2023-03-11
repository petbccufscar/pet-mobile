import 'package:flutter/material.dart';
import 'package:pet_mobile/model/event_data_source.dart';
import 'package:pet_mobile/provider/event_provider.dart';
import 'package:pet_mobile/widgets/tasks_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  final CalendarController calendarController;

  const CalendarWidget({Key? key, required this.calendarController})
      : super(key: key);
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Container(
      child: SfCalendar(
        headerHeight: 0,
        controller: widget.calendarController,
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
    );
  }
}
