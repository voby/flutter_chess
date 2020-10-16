import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

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
        child: SvgPicture.asset(assetName),
      ),
    );
  }

  String get assetName {
    return 'assets/${color.toString().split('.')[1]}_${type.toString().split('.')[1]}.svg';
  }
}
