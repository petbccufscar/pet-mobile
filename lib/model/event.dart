import 'package:flutter/material.dart';

class Event {
  final String _title;
  final String _description;
  final DateTime _from;
  final DateTime _to;
  final Color _backgroundColor;
  final bool _isAllDay;

  String get title => this._title;

  String get description => this._description;

  DateTime get from => this._from;

  DateTime get to => this._to;

  Color get backgroundColor => this._backgroundColor;

  bool get isAllDay => this._isAllDay;

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
