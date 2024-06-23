import 'package:pet_mobile/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_mobile/utils.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  DateTime _selectedDate = DateTime.now();

  List<Event> get events => _events;

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<Event> getEventsOfSelectedDate(DateTime selectedDate) {
    return _events
        .where(
          (event) =>
              Utils.toDate(event.dataHora) == Utils.toDate(selectedDate),
        )
        .toList();
  }

  void addEvent(Event event) {
    final newId = event.id;
    final newEvent = event.copyWith(id: newId);
    _events.add(newEvent);
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.removeWhere((e) => e.id == event.id);
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexWhere((e) => e.id == oldEvent.id);

    if (index != -1) {
      _events[index] = newEvent;
      notifyListeners();
    }
  }
}