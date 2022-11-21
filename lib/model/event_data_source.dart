import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../model/event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).getFrom;

  @override
  DateTime getEndTime(int index) => getEvent(index).getTo;

  @override
  String getSubject(int index) => getEvent(index).getTitle;

  String getDescription(int index) => getEvent(index).getDescription;

  @override
  Color getColor(int index) => getEvent(index).getBackgroundColor;

  @override
  bool isAllDay(int index) => getEvent(index).getIsAllDay;
}
