import 'package:flutter/material.dart';
import 'package:flutter_chess/pawn_painter.dart';
import 'package:flutter_chess/rook_painter.dart';

enum PieceColor { black, white }
enum PieceType { king, queen, rook, bishop, knight, pawn }

class Piece extends StatelessWidget {
  const Piece({
    Key key,
    @required this.type,
    @required this.color,
  }) : super(key: key);
  final PieceType type;
  final PieceColor color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        child: CustomPaint(
          painter: getPainter,
        ),
      ),
    );
  }

  CustomPainter get getPainter {
    final majorColor = color == PieceColor.white ? Colors.white : Colors.black;
    final minorColor = color == PieceColor.white ? Colors.black : Colors.white;

    switch (type) {
      case PieceType.rook:
        return RookPainter(majorColor: majorColor, minorColor: minorColor);
      default:
        return PawnPainter(color: majorColor);
    }
  }
}
