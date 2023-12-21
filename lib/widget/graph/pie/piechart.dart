import 'package:bhart_political_reports/widget/graph/pie/pie_chart_paint.dart';
import 'package:flutter/material.dart';

class PieChartView extends StatefulWidget {
  final List<Category> categories;

  const PieChartView({super.key, required this.categories});

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  @override
  Widget build(BuildContext context) {
    final String Total = "140";
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(193, 214, 233, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.black, //outer shadow of the chart
              ),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1),
              )
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: CustomPaint(
                      child: Center(),
                      foregroundPainter: dPicChart(
                          width: constraints.maxWidth * 0.5,
                          categories: widget.categories)),
                ),
              ),
              Center(
                child: Container(
                  height: constraints.maxWidth * 0.4,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(193, 214, 233, 1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          offset: Offset(-1, -1),
                          color: Colors.white,
                        ),
                        BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                          color: Colors.black.withOpacity(0.5),
                        )
                      ]),
                  child: Center(
                    child: Text(Total),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
