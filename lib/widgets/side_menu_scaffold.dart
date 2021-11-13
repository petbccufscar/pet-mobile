import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideMenuScaffold extends StatelessWidget {
  SideMenuScaffold({
    Key? key,
    required this.appBarTitle,
    required this.body
  }) : super(key: key);

  final Widget appBarTitle;
  final Widget body;
  final GlobalKey<ScaffoldState> _sideMenuKey = new GlobalKey();

  openDrawer() {
    _sideMenuKey.currentState!.openDrawer();
  }

  closeDrawer() {
    _sideMenuKey.currentState!.openEndDrawer();
  }

  openCloseDrawer() {
    if (_sideMenuKey.currentState!.isDrawerOpen == false) {
      openDrawer();
    } else {
      closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.dehaze),
            onPressed: openCloseDrawer
        ),
      ),
      body: Scaffold(
        key: _sideMenuKey,
        drawer: _SideMenu(closeDrawer: closeDrawer),
        body: body,
      ),
    );
  }
}

class _SideMenu extends StatelessWidget {
  _SideMenu({
    Key? key,
    required this.closeDrawer
  }) : super(key: key);

  final void Function() closeDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue.shade100,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            _SideMenuItem(
              iconData: Icons.group,
              text: AppLocalizations.of(context)!.help_page_title,
              onTap: () {
                closeDrawer();
                String? current = ModalRoute.of(context)!.settings.name;
                if (current != '/help') Navigator.pushNamed(context, '/help');
              },
            ),
            Divider(height: 1, thickness: 1, color: Colors.red.shade500),
            _SideMenuItem(
              iconData: Icons.calendar_today,
              text: 'Calendário',
              onTap: () {
                closeDrawer();
                String? current = ModalRoute.of(context)!.settings.name;
                if (current != '/calendar') Navigator.pushNamed(context, '/calendar');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SideMenuItem extends StatelessWidget {
  _SideMenuItem({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final void Function() onTap;

  // TODO Extract style
  final TextStyle textStyle = const TextStyle(
    fontSize: 25.0,
    color: Colors.black87,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(this.iconData, size: 35),
      title: Text(text, style: textStyle),
      onTap: onTap,
    );
  }
}