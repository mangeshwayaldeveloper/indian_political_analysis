import 'package:bhart_political_reports/widget/graph/pie/pie_chart_paint.dart';
import 'package:flutter/material.dart';

class CategoriesRow extends StatefulWidget {
  final List<Category> categories;

  const CategoriesRow({super.key, required this.categories});

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var category in widget.categories)
              Legendcategories(
                text: category.name,
                index: widget.categories.indexOf(category),
                categories: widget.categories,
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
            ),
          ],
        ));
  }
}

class Legendcategories extends StatelessWidget {
  const Legendcategories({
    super.key,
    required this.text,
    required this.index,
    required this.categories,
  });

  final int index;
  final String text;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final Color categoryColor =
        categories[index % categories.length].color; // Corrected variable name
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: categoryColor,
          ),
        ),
        SizedBox(width: 20),
        Text(text.capitalize())
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
