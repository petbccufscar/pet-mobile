import 'package:pet_mobile/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_mobile/utils.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  DateTime _selectedDate = DateTime.now();

  List<Event> get events => _events;

  DateTime get selectedDate => _selectedDate;

  List<Event> getEventsOfSelectedDate(DateTime selectedDate) {
    return _events
        .where((event) =>
            Utils.toDate(event.from) == Utils.toDate(selectedDate) ||
            Utils.toDate(event.to) == Utils.toDate(selectedDate))
        .toList();
  }

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);

    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);

    _events[index] = newEvent;
    notifyListeners();
  }
}
