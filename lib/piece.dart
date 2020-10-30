import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'engine/piece_info.dart';

class Piece extends StatelessWidget {
  const Piece({
    Key key,
    @required this.pieceInfo,
    this.containerColor,
  }) : super(key: key);
  final PieceInfo pieceInfo;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: containerColor,
        child: SvgPicture.asset(assetName),
      ),
    );
  }

  String get assetName {
    return 'assets/${pieceInfo.color.toString().split('.').last}_${pieceInfo.type.toString().split('.').last}.svg';
  }
}
