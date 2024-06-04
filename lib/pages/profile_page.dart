import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/* Creating the chart */

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double domAmount;
  final double segAmount;
  final double terAmount;
  final double quaAmount;
  final double quiAmount;
  final double sexAmount;
  final double sabAmount;

  BarData({
    required this.domAmount,
    required this.segAmount,
    required this.terAmount,
    required this.quaAmount,
    required this.quiAmount,
    required this.sexAmount,
    required this.sabAmount,
  });

  late final List<IndividualBar> barData;

  void initBarData() {
    barData = [
      // Domingo
      IndividualBar(x: 0, y: domAmount),
      // Segunda
      IndividualBar(x: 1, y: segAmount),
      // Terça
      IndividualBar(x: 2, y: terAmount),
      // Quarta
      IndividualBar(x: 3, y: quaAmount),
      // Quinta
      IndividualBar(x: 4, y: quiAmount),
      // Sexta
      IndividualBar(x: 5, y: sexAmount),
      // Sábado
      IndividualBar(x: 6, y: sabAmount),
    ];
  }
}

class MyBarChart extends StatelessWidget {
  final BarData barData;

  const MyBarChart({Key? key, required this.barData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    barData.initBarData();

    return BarChart(
      BarChartData(
        maxY: 24,
        minY: 0,
        gridData: FlGridData(show: true,),
        borderData: FlBorderData(
          show: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles,))
        ),
        barGroups: barData.barData.map((data) {
          return BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(
                toY: data.y,
                color: Colors.lightBlue[600],
                width: 20,
                borderRadius: BorderRadius.circular(2)
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  Widget text;
  switch (value.toInt()){
    case 0:
      text = const Text('D', style: style,);
      break;
    case 1:
      text = const Text('S', style: style,);
      break;
    case 2:
      text = const Text('T', style: style,);
      break;
    case 3:
      text = const Text('Q', style: style,);
      break;
    case 4:
      text = const Text('Q', style: style,);
      break;
    case 5:
      text = const Text('S', style: style,);
      break;
    case 6:
      text = const Text('S', style: style,);
      break;
    default:
      text = const Text('', style: style,);
      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
/* End of chart creation */

class ProfilePage extends StatefulWidget {
  final String memberName;

  const ProfilePage({Key? key, this.memberName = 'Nome Padrão'}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _hoursAnimation;
  late Animation<double> _activitiesAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 2));

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
    // Initialize BarData with some example data
    BarData barData = BarData(
      domAmount: 4,
      segAmount: 5,
      terAmount: 2,
      quaAmount: 7,
      quiAmount: 8,
      sexAmount: 16,
      sabAmount: 2,
    );

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
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 70, right: 16.0, left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CircleAvatar(
                          radius: 62,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://petbcc.ufscar.br/media/images/equipe/IMG_20210403_142933_015.jpg_SDflxTe.png',
                            ),
                          ),
                        ),
                        SizedBox(height: 16), // Space between avatar and text
                        Text(
                          'Bruno Pereira',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'PET BCC',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF008db9),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Horas Semanais',
                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    _hoursAnimation.value.round().toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1485BF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Atividades Realizadas',
                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                  Text(
                                    _activitiesAnimation.value.round().toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1485BF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Container(
                          height: 300, // Set a fixed height for the chart
                          child: MyBarChart(barData: barData),
                        ),
                        SizedBox(height: 32), // Space after the chart
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
                                      style: TextStyle(fontSize: 16),
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
                                      ),
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
                                      style: TextStyle(fontSize: 16),
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
