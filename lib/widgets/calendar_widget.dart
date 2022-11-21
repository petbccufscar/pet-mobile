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

class _CalendarWidgetState extends State<CalendarWidget> {
  bool showAgenda = false;

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return GestureDetector(
      onVerticalDragEnd: (details) {
        setState(() {
          if (details.primaryVelocity! >= 0) {
            showAgenda = false;
          } else {
            showAgenda = true;
          }
        });
      },
      child: Container(
        color: Colors.white,
        child: SfCalendar(
          headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
          controller: widget.calendarController,
          dataSource: EventDataSource(events),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          monthViewSettings: MonthViewSettings(
            showAgenda: showAgenda,
          ),
          showNavigationArrow: true,
          onTap: (details) {
            final provider = Provider.of<EventProvider>(context, listen: false);
            List<Event> dayEvents =
                provider.getEventsOfSelectedDate(details.date!);

            if (dayEvents.isEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventEditingPage(),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.symmetric(vertical: 24.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    title: Text(
                        '${details.date!.day}, ${DateFormat(DateFormat.WEEKDAY, 'pt_Br').format(details.date!)}'),
                    content: Container(
                      width: double.minPositive,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dayEvents.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EventEditingPage(
                                        event: dayEvents[index]),
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
                                      Text(
                                        '${Utils.toTime(dayEvents[index].getFrom)}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      VerticalDivider(
                                        thickness: 2,
                                        color:
                                            dayEvents[index].getBackgroundColor,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${dayEvents[index].getTitle}',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '${Utils.toTime(dayEvents[index].getFrom)} - ${Utils.toTime(dayEvents[index].getTo)}',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar')),
                      TextButton(onPressed: () {}, child: Text('Adicionar'))
                    ],
                  );
                },
              );
            }
          },
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
}
