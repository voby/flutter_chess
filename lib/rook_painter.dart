import 'package:flutter/material.dart';

class RookPainter extends CustomPainter {
  const RookPainter({
    @required this.majorColor,
    @required this.minorColor,
  });
  final Color majorColor;
  final Color minorColor;

  final double strokeWidth = 2;

  final double bottomMargin = 0.1;

  final double w1 = 0.28;
  final double w2 = 0.07;
  final double w3 = 0.04;
  final double w4 = 0.05;
  final double w5 = 0.1;
  final double w6 = 0.05;
  final double w7 = 0.05;

  final double h1 = 0.08;
  final double h2 = 0.1;
  final double h3 = 0.1;
  final double h4 = 0.2;
  final double h5 = 0.1;
  final double h6 = 0.1;
  final double h7 = 0.03;
  final double h8 = 0.03;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = majorColor;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.black;
    final thinLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7
      ..color = minorColor;
    final thickLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = minorColor;

    final p0 = Offset(size.width / 2, size.height * (1 - bottomMargin));
    final p1 = Offset(size.width * ((1 - w1 * 2) / 2), p0.dy);
    final p2 = Offset(p1.dx, p1.dy - (size.height * h1));
    final p3 = Offset(p2.dx + (size.width * w2), p2.dy);
    final p4 = Offset(p3.dx, p3.dy - (size.height * h2));
    final p5 = Offset(p4.dx + (size.width * w3), p4.dy - (size.height * h3));
    final p6 = Offset(p5.dx, p5.dy - (size.height * h4));
    final p7 = Offset(p6.dx - (size.width * w4), p6.dy - (size.height * h5));
    final p8 = Offset(p7.dx, p7.dy - (size.height * h6));
    final p9 = Offset(p8.dx + (size.width * w5), p8.dy);
    final p10 = Offset(p9.dx, p9.dy + (size.height * h7));
    final p11 = Offset(p10.dx + (size.width * w6), p10.dy);
    final p12 = Offset(p11.dx, p11.dy - (size.height * h7));
    final p13 = Offset(p0.dx, p12.dy);

    final p14 = mirror(p12, size);
    final p15 = mirror(p11, size);
    final p16 = mirror(p10, size);
    final p17 = mirror(p9, size);
    final p18 = mirror(p8, size);
    final p19 = mirror(p7, size);
    final p20 = mirror(p6, size);
    final p21 = mirror(p5, size);
    final p22 = mirror(p4, size);
    final p23 = mirror(p3, size);
    final p24 = mirror(p2, size);
    final p25 = mirror(p1, size);

    final path = Path()
      ..moveTo(p0.dx, p0.dy)
      // left side
      ..arcToPoint(p1)
      ..arcToPoint(p2)
      ..arcToPoint(p3)
      ..arcToPoint(p4)
      ..arcToPoint(p5)
      ..arcToPoint(p6)
      ..arcToPoint(p7)
      ..arcToPoint(p8)
      ..arcToPoint(p9)
      ..arcToPoint(p10)
      ..arcToPoint(p11)
      ..arcToPoint(p12)
      ..arcToPoint(p13)
      // right side
      ..arcToPoint(p14)
      ..arcToPoint(p15)
      ..arcToPoint(p16)
      ..arcToPoint(p17)
      ..arcToPoint(p18)
      ..arcToPoint(p19)
      ..arcToPoint(p20)
      ..arcToPoint(p21)
      ..arcToPoint(p22)
      ..arcToPoint(p23)
      ..arcToPoint(p24)
      ..arcToPoint(p25)
      // to start
      ..lineTo(p0.dx, p0.dy);

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);

    canvas.drawLine(p3, p23, thickLine);
    canvas.drawLine(p4, p22, thickLine);
    canvas.drawLine(p5, p21, thinLine);
    canvas.drawLine(p6, p20, thinLine);
    canvas.drawLine(p7, p19, thickLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  mirror(Offset p, Size size) {
    return Offset(size.width - p.dx, p.dy);
  }
}
