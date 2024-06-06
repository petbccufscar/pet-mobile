import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'bar_data.dart';

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