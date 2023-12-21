import 'dart:math';

import 'package:flutter/cupertino.dart';

class dPicChart extends CustomPainter {
  final List<Category> categories;
  final double width;

  dPicChart({required this.categories, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;
    double total = 0;
    categories.forEach((expenses) => total += expenses.numbers);
    double startRadian = -pi / 2;
    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      final sweepRadian = currentCategory.numbers / total * 2 * pi;
      paint.color = currentCategory.color;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startRadian, sweepRadian, false, paint);
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Category {
  final String name;
  final double numbers;
  final Color color;

  Category({required this.name, required this.numbers, required this.color});
}
