import 'package:flutter/material.dart';

import 'engine/board_history.dart';
import 'engine/enums.dart';
import 'engine/move_validation.dart';
import 'engine/square.dart';
import 'piece.dart';

class PieceLayer extends StatelessWidget {
  final List<Square> legalMoves;
  final Square fromSquare;
  final PieceColor focusSide;
  final BoardHistory boardHistory;
  final double screenWidth;
  final VoidCallback Function(Square) onSquareTap;

  const PieceLayer({
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
          ...boardHistory.currentState.piecePositions.map((piecePosition) {
            final isLegalMoveSquare = legalMoves.contains(piecePosition.square);

            final isKing = piecePosition != null &&
                piecePosition.pieceInfo.type == PieceType.king &&
                piecePosition.pieceInfo.color ==
                    boardHistory.currentState.movingColor;
            final isCheck = isKing &&
                isSquareUnderAttack(piecePosition.pieceInfo.color,
                    piecePosition.square, boardHistory.currentState);
            final isStalemate =
                isKing && boardHistory.currentState.isStalemate();
            final isCheckmate =
                isKing && boardHistory.currentState.isCheckmate();

            final border = Border.all(
              color: piecePosition != null && isLegalMoveSquare
                  ? Colors.redAccent.withOpacity(0.7)
                  : piecePosition.square == fromSquare || isLegalMoveSquare
                      ? Colors.greenAccent.withOpacity(0.7)
                      : isCheck
                          ? Colors.redAccent
                          : isStalemate
                              ? Colors.yellowAccent.withOpacity(.7)
                              : Colors.transparent,
              width: 2,
            );

            final left = focusSide == PieceColor.white
                ? screenWidth * piecePosition.square.fileIndex / 8
                : screenWidth -
                    (screenWidth * (piecePosition.square.fileIndex + 1) / 8);
            final bottom = focusSide == PieceColor.white
                ? screenWidth * piecePosition.square.rankIndex / 8
                : screenWidth -
                    (screenWidth * (piecePosition.square.rankIndex + 1) / 8);

            return AnimatedPositioned(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 500),
              left: left,
              bottom: bottom,
              key: Key(piecePosition.pieceInfo.id + focusSide.toString()),
              child: GestureDetector(
                onTap: onSquareTap(piecePosition.square),
                child: Container(
                  width: screenWidth / 8,
                  height: screenWidth / 8,
                  decoration: BoxDecoration(
                    color: isCheckmate
                        ? Colors.redAccent.withOpacity(0.8)
                        : isStalemate
                            ? Colors.yellowAccent.withOpacity(0.8)
                            : fromSquare == piecePosition.square
                                ? Colors.greenAccent.withOpacity(0.3)
                                : isLegalMoveSquare
                                    ? Colors.redAccent.withOpacity(0.3)
                                    : null,
                    border: border,
                  ),
                  child: Piece(
                    pieceInfo: piecePosition.pieceInfo,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
