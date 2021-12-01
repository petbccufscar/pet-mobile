// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';
import 'package:pet_mobile/widgets/side_menu_scaffold.dart';
import 'package:provider/provider.dart';
import '../provider/event_provider.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        home: MainPage(),
      ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SideMenuScaffold(
      appBarTitle: Text('Calendário'),
      body: CalendarWidget(),
    );
  }
}
