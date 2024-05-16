import 'package:flutter/material.dart';
// import 'package:pet_mobile/pages/list_projects_page.dart';

class ProfilePage extends StatefulWidget {
  final String memberName;

  const ProfilePage({Key? key, this.memberName = 'Nome Padrão'}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _hoursAnimation;
  late Animation<double> _activitiesAnimation;


  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _hoursAnimation = Tween<double>(begin: 0.0, end: 12.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    _activitiesAnimation = Tween<double>(begin: 0.0, end: 456.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1485BF),
            Color(0xFF61CFD7),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
              child: Container(
                  margin: EdgeInsets.only(top: 32.0),
                  child: Stack(alignment: Alignment.topCenter, children: [
                    Container(
                      margin: EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 70, right: 16.0, left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Bruno Pereira',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'PET BCC',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF008db9)),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Horas Semanais',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                      Text(
                                        _hoursAnimation.value
                                            .round()
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1485BF),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Atividades Realizadas',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                      Text(
                                        _activitiesAnimation.value
                                            .round()
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1485BF),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              height: 50,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => (ListProjectsPage()),
                                    //   ),
                                    // );
                                  },
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Meus Projetos',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Wrap(
                                        spacing: 12,
                                        children: [
                                          Text(
                                            '5',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Minhas Atividades',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Wrap(
                                        spacing: 12,
                                        children: [
                                          Text(
                                            '',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    'https://petbcc.ufscar.br/media/images/equipe/IMG_20210403_142933_015.jpg_SDflxTe.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])))),
    );
  }
}
