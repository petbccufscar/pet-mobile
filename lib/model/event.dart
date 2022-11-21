import 'package:flutter/material.dart';

class Event {
  final String _title;
  final String _description;
  final DateTime _from;
  final DateTime _to;
  final Color _backgroundColor;
  final bool _isAllDay;

  String get getTitle => this._title;

  String get getDescription => this._description;

  DateTime get getFrom => this._from;

  DateTime get getTo => this._to;

  Color get getBackgroundColor => this._backgroundColor;

  bool get getIsAllDay => this._isAllDay;

  const Event({
    required String title,
    required String description,
    required DateTime from,
    required DateTime to,
    Color backgroundColor = Colors.lightBlue,
    bool isAllDay = false,
  })  : _title = title,
        _description = description,
        _from = from,
        _to = to,
        _backgroundColor = backgroundColor,
        _isAllDay = isAllDay;
}
