import 'individual_bar.dart';

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