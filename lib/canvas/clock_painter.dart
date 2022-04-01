import 'dart:math';

import 'package:dental_app/resources/colors.dart';
import 'package:dental_app/resources/dimens.dart';
import 'package:flutter/material.dart';

class ClockPainter extends StatelessWidget {
  const ClockPainter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(CLOCK_CANVAS_WIDTH, CLOCK_CANVAS_HEIGHT),
        painter: ClockPaint(),
      ),
    );
  }
}

class ClockPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var outterCirclePaint = Paint()
      ..color = LIGHT_BLUE_COLOR
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    var midCirclePaint = Paint()
      ..color = MEDIUM_BLUE_COLOR
      ..strokeWidth = 15
      ..style = PaintingStyle.fill;

    var innerCirclePaint = Paint()
      ..color = DARK_BLUE_COLOR
      ..strokeWidth = 15
      ..style = PaintingStyle.fill;

    var linePaint = Paint()
      ..strokeWidth = 4
      ..color = Colors.white;

    var dottedPaint = Paint()..color = Colors.white;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    double filledCircleRadius = 1.5;
    int numberOfDots = 20;
    double radius = CLOCK_DOTTED_CIRCLE_RADIUS;
    final double radiantStep = 2 * pi / numberOfDots;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        CLOCK_OUTTER_CIRCLE_RADIUS, midCirclePaint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        CLOCK_INNER_CIRCLE_RADIUS, innerCirclePaint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        CLOCK_OUTTER_CIRCLE_RADIUS, outterCirclePaint);

    for (int i = 0; i < numberOfDots; i++) {
      canvas.drawCircle(
        Offset(centerX + sin(i * radiantStep) * radius,
            centerY + cos(i * radiantStep) * radius),
        filledCircleRadius,
        dottedPaint,
      );
    }

    canvas.drawLine(Offset(277.5,centerY), Offset(330,centerY), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
