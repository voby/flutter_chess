import 'package:flutter/material.dart';

class PawnPainter extends CustomPainter {
  const PawnPainter({this.color});
  final Color color;

  final double strokeWidth = 2;

  final double bottomMargin = 0.1;

  final double bottomRadius = 15;
  final double middleRadius = 8;
  final double topRadius = 5;

  final double bottomWidth = 0.5;
  final double middleWidth = 0.25;
  final double topWidth = 0.15;

  final double bottomHeight = 0.32;
  final double middleHeight = 0.22;
  final double topHeight = 0.15;

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.black;

    final p0 = Offset(
      size.width / 2,
      size.height * (1 - bottomMargin),
    );
    final p1 = Offset(
      size.width * ((1 - bottomWidth) / 2),
      p0.dy,
    );
    final p2 = Offset(
      size.width * ((1 - middleWidth) / 2),
      p1.dy - (size.height * bottomHeight),
    );
    final p3 = Offset(
      size.width * ((1 - topWidth) / 2),
      p2.dy - (size.height * middleHeight),
    );
    final p4 = Offset(
      p0.dx,
      p3.dy - (size.height * topHeight),
    );
    final p5 = Offset(
      p3.dx + (size.width * topWidth),
      p3.dy,
    );
    final p6 = Offset(
      p2.dx + (size.width * middleWidth),
      p2.dy,
    );
    final p7 = Offset(
      p1.dx + (size.width * bottomWidth),
      p1.dy,
    );

    final path = Path()
      ..moveTo(p0.dx, p0.dy)
      // left side
      ..lineTo(p1.dx, p1.dy)
      ..arcToPoint(p2, radius: Radius.circular(bottomRadius))
      ..arcToPoint(p3, radius: Radius.circular(middleRadius))
      ..arcToPoint(p4, radius: Radius.circular(topRadius))
      // right side
      ..arcToPoint(p5, radius: Radius.circular(topRadius))
      ..arcToPoint(p6, radius: Radius.circular(middleRadius))
      ..arcToPoint(p7, radius: Radius.circular(bottomRadius))
      // to start
      ..lineTo(p0.dx, p0.dy);

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
