import 'dart:ui';

import 'package:bhart_political_reports/widget/graph/pie/pie_chart_paint.dart';


final PCategories = [
  Category(
      name: "Present", numbers: 30, color: Color.fromRGBO(123, 201, 82, 1)),
  Category(name: "Absent", numbers: 90, color: Color.fromRGBO(252, 91, 82, 1)),
];

final List<Category> updatedCategories = [
  Category(
      name: "Present", numbers: 10, color: Color.fromRGBO(255, 171, 76, 1)),
  Category(
      name: "Week Off", numbers: 80, color: Color.fromRGBO(139, 135, 130, 1)),
  Category(
      name: "Preset Half", numbers: 80, color: Color.fromRGBO(239, 5, 130, 1)),
  // Add more categories as needed
];
