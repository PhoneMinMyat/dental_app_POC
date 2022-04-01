import 'package:dental_app/resources/colors.dart';
import 'package:dental_app/resources/dimens.dart';
import 'package:flutter/material.dart';

class VerticalLinePainter extends StatelessWidget {
  final double height;
  final bool isDashedLine;
  final bool isBlueDotShow;
  const VerticalLinePainter(
      {required this.height,
      this.isDashedLine = true,
      this.isBlueDotShow = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(CLOCK_DOTTED_CIRCLE_RADIUS);
    return SizedBox(
        width: VERTICAL_LINE_SECTION_WIDTH,
        height: height,
        child: Stack(
          //fit: StackFit.expand,

          overflow: Overflow.visible,
          children: [
            Positioned.fill(
              child: CustomPaint(
                size: Size(VERTICAL_LINE_SECTION_WIDTH, height),
                painter: (isDashedLine) ? DashedLinePainter() : LinePainter(),
              ),
            ),
            Positioned(
              bottom: -MARGIN_MEDIUM_2x / 2,
              left: -MARGIN_MEDIUM_2x / 2,
              child: Visibility(
                visible: isBlueDotShow,
                child: Container(
                  width: MARGIN_MEDIUM_2x,
                  height: MARGIN_MEDIUM_2x,
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                      color: DARK_BLUE_COLOR, shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ));
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double spaceWidth = 3;
    double startY = 0;
    var paint = Paint()
      ..color = LIGHT_GREY_COLOR
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + spaceWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = LIGHT_GREY_COLOR
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
