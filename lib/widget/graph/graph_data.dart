import 'bar_graph.dart';

class BarData {
  final double sunday;
  final double monday;
  final double tueday;
  final double wednsday;
  final double thursday;
  final double friday;
  final double saturday;

  BarData({
    required this.sunday,
    required this.monday,
    required this.tueday,
    required this.wednsday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sunday),
      IndividualBar(x: 1, y: monday),
      IndividualBar(x: 2, y: tueday),
      IndividualBar(x: 3, y: wednsday),
      IndividualBar(x: 4, y: thursday),
      IndividualBar(x: 5, y: friday),
      IndividualBar(x: 6, y: saturday),
    ];
  }
}
