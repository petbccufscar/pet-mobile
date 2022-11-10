import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_mobile/model/navigation_item.dart';

class SideMenuScaffoldWithProfileHeader extends StatelessWidget {
  SideMenuScaffoldWithProfileHeader({
    Key? key,
    required this.appBarTitle,
    required this.body,
    this.appBarActions,
    this.floatingActionButton,
  }) : super(key: key);

  final Widget appBarTitle;
  final List<Widget>? appBarActions;

  final Widget body;
  final Widget? floatingActionButton;
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
    return SafeArea(
        child: Scaffold(
      key: _sideMenuKey,
      primary: true,
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: appBarActions,
      ),
      drawer: _SideMenu(closeDrawer: closeDrawer),
      body: body,
      floatingActionButton: floatingActionButton,
    ));
  }
}

class _SideMenu extends StatefulWidget {
  final void Function() closeDrawer;
  const _SideMenu({Key? key, required this.closeDrawer}) : super(key: key);

  @override
  State<_SideMenu> createState() => __SideMenuState();
}

NavigationItem _currentItemSelected = NavigationItem.home;
int? teste;

class __SideMenuState extends State<_SideMenu> {
  _navigateTo(BuildContext context, String route, NavigationItem item) {
    widget.closeDrawer();
    String? current = ModalRoute.of(context)!.settings.name;
    print(current);
    if (current != route) {
      setState(() {
        _currentItemSelected = item;
      });
      Navigator.popAndPushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Bruno Pereira'),
            accountEmail: Text('PET BCC'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Text(
                  'Foto',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              //backgroundImage: AssetImage(''),
              radius: 35,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Color(0xFF1485BF),
              Color(0xFF3CACCB),
              Color(0xFF61CFD7),
            ])),
            margin: EdgeInsets.zero,
          ),
          _SideMenuItem(
            iconData: Icons.calendar_today,
            text: 'Calendário',
            isSelected: _currentItemSelected == NavigationItem.calendar,
            onTap: () =>
                _navigateTo(context, '/calendar', NavigationItem.calendar),
          ),
          _SideMenuItem(
            iconData: Icons.group,
            text: 'Reunião',
            isSelected: _currentItemSelected == NavigationItem.meet,
            onTap: () => _navigateTo(context, '/meet', NavigationItem.meet),
          ),
          _SideMenuItem(
            iconData: Icons.folder,
            text: 'Projetos',
            isSelected: _currentItemSelected == NavigationItem.projects,
            onTap: () =>
                _navigateTo(context, '/projects', NavigationItem.projects),
          ),
          _SideMenuItem(
            iconData: Icons.note_alt_rounded,
            text: 'Atividades',
            isSelected: _currentItemSelected == NavigationItem.activities,
            onTap: () {},
          ),
          _SideMenuItem(
            iconData: Icons.person,
            text: 'Perfil',
            isSelected: _currentItemSelected == NavigationItem.profile,
            onTap: () {},
          ),
          _SideMenuItem(
            iconData: Icons.question_mark,
            text: AppLocalizations.of(context)!.help_page_title,
            isSelected: _currentItemSelected == NavigationItem.help,
            onTap: () => _navigateTo(context, '/help', NavigationItem.help),
          ),
          Divider(),
          _SideMenuItem(
            iconData: Icons.add,
            text: "Adicionar Projetos",
            isSelected: _currentItemSelected == NavigationItem.addProject,
            onTap: () => _navigateTo(
                context, '/register/project', NavigationItem.addProject),
          ),
          _SideMenuItem(
            iconData: Icons.add,
            text: 'Registrar Petiano',
            isSelected: _currentItemSelected == NavigationItem.addPetiano,
            onTap: () => _navigateTo(
                context, '/register/petiano', NavigationItem.addPetiano),
          ),
          _SideMenuItem(
            iconData: Icons.add,
            text: 'Registrar Grupo',
            isSelected: _currentItemSelected == NavigationItem.addGroup,
            onTap: () => _navigateTo(
                context, '/register/group', NavigationItem.addGroup),
          ),
          _SideMenuItem(
            iconData: Icons.add,
            text: 'Login',
            isSelected: _currentItemSelected == NavigationItem.login,
            onTap: () => _navigateTo(context, '/login', NavigationItem.login),
          ),
        ],
      ),
    );
  }
}

class _SideMenuItem extends StatelessWidget {
  _SideMenuItem(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  final IconData iconData;
  final String text;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        iconColor: Color(0xFF757575),
        textColor: Color(0xFF757575),
        selected: isSelected,
        selectedTileColor: Color(0xFF1485BF),
        selectedColor: Colors.white,
        leading: Icon(
          this.iconData,
          size: 35,
        ),
        title: Text(text,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            )),
        onTap: onTap,
      ),
    );
  }
}
