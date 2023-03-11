// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pet_mobile/pages/event_editing_page.dart';
import 'package:pet_mobile/widgets/calendar_widget.dart';

import 'package:pet_mobile/widgets/side_menu_scaffold_with_profile_header.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController = CalendarController();

  @override
  initState() {
    _calendarController.view = CalendarView.week;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SideMenuScaffoldWithProfileHeader(
        appBarTitle: Row(children: [
          Text('Calendário'),
          Expanded(
            child: SizedBox(),
          )
        ]),
        appBarActions: <Widget>[
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
        body: CalendarWidget(
          calendarController: _calendarController,
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
