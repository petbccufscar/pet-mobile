// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pet_mobile/provider/event_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/calendar_widget.dart';

void main() => runApp(CalendarPage());

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to Flutter',
        home: MainPage(),
      ));
}

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Calendário'),
      centerTitle: true,
    ),
    body: CalendarWidget(),
  );
}