import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_mobile/model/event.dart';
import 'package:pet_mobile/model/event_data_source.dart';
import 'package:pet_mobile/pages/event_editing_page.dart';
import 'package:pet_mobile/provider/event_provider.dart';
import 'package:pet_mobile/utils.dart';
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

class _CalendarWidgetState extends State<CalendarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController agendaController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    agendaController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    animation = CurvedAnimation(
        parent: agendaController,
        curve: Curves.ease,
        reverseCurve: Curves.easeOut);

    agendaController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    agendaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return GestureDetector(
      onVerticalDragUpdate: _displayAgenda,
      child: Container(
        color: Colors.white,
        child: SfCalendar(
          headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
          controller: widget.calendarController,
          dataSource: EventDataSource(events),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          monthViewSettings: MonthViewSettings(
              showAgenda: true,
              agendaViewHeight:
                  (MediaQuery.of(context).size.height / 3.0) * animation.value),
          showNavigationArrow: true,
          onTap: _onCalendarCellTapped,
          onLongPress: (details) {
            showModalBottomSheet(
              context: context,
              builder: (context) => TasksWidget(),
            );
          },
        ),
      ),
    );
  }

  void _displayAgenda(DragUpdateDetails details) {
    if (0 < details.delta.dy) {
      agendaController.reverse();
    } else {
      agendaController.forward();
    }
  }

  void _onCalendarCellTapped(CalendarTapDetails details) {
    final provider = Provider.of<EventProvider>(context, listen: false);
    provider.setDate(details.date!);
    List<Event> dayEvents = provider.getEventsOfSelectedDate(details.date!);

    if (dayEvents.isEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EventEditingPage(),
        ),
      );
    } else {
      _displayAppointmentsDialog(dayEvents, details.date!);
    }
  }

  Future<void> _displayAppointmentsDialog(
      List<Event> dayEvents, DateTime selectedDate) {
    dayEvents.sort(
      (a, b) {
        return a.from.compareTo(b.from);
      },
    );

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 24.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EventEditingPage(),
                      ),
                    );
                  },
                  child: Text('Adicionar'))
            ],
            title: Text(
              '${selectedDate.day}, ${DateFormat(DateFormat.WEEKDAY, 'pt_Br').format(selectedDate)}',
            ),
            content: _buildAppointmentsCardList(dayEvents));
      },
    );
  }

  Widget _buildAppointmentsCardList(List<Event> dayEvents) {
    return Container(
      width: double.minPositive,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dayEvents.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      EventEditingPage(event: dayEvents[index]),
                ),
              );
            },
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: dayEvents[index].isAllDay
                          ? SizedBox()
                          : Text(
                              '${Utils.toTime(dayEvents[index].from)}',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: dayEvents[index].backgroundColor,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dayEvents[index].title}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            dayEvents[index].isAllDay
                                ? 'Todo o dia'
                                : '${Utils.toTime(dayEvents[index].from)} - ${Utils.toTime(dayEvents[index].to)}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
