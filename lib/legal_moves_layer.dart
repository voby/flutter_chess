import 'package:flutter/material.dart';

import 'engine/board_history.dart';
import 'engine/enums.dart';
import 'engine/square.dart';

class LegalMovesLayer extends StatelessWidget {
  final List<Square> legalMoves;
  final Square fromSquare;
  final PieceColor focusSide;
  final BoardHistory boardHistory;
  final double screenWidth;
  final VoidCallback Function(Square) onSquareTap;

  const LegalMovesLayer({
    Key key,
    @required this.legalMoves,
    @required this.fromSquare,
    @required this.focusSide,
    @required this.boardHistory,
    @required this.screenWidth,
    @required this.onSquareTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: screenWidth,
      child: Stack(
        children: [
          ...boardHistory.currentState.getLegalMoves(fromSquare).map(
            (square) {
              final left = focusSide == PieceColor.white
                  ? screenWidth * square.fileIndex / 8
                  : null;
              final bottom = focusSide == PieceColor.white
                  ? screenWidth * square.rankIndex / 8
                  : null;
              final right = focusSide != PieceColor.white
                  ? screenWidth * square.fileIndex / 8
                  : null;
              final top = focusSide != PieceColor.white
                  ? screenWidth * square.rankIndex / 8
                  : null;

              return Positioned(
                left: left,
                bottom: bottom,
                right: right,
                top: top,
                child: GestureDetector(
                  onTap: onSquareTap(square),
                  child: Container(
                    width: screenWidth / 8,
                    height: screenWidth / 8,
                    color: Colors.greenAccent.withOpacity(0.3),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
