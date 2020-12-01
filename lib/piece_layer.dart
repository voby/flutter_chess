import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'engine/enums.dart';
import 'engine/move_validation.dart';
import 'piece.dart';
import 'room.dart';

class PieceLayer extends ConsumerWidget {
  const PieceLayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(roomBlockProvider.state);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: screenWidth,
      child: Stack(
        children: [
          ...state.boardHistory.currentState.piecePositions
              .map((piecePosition) {
            final isLegalMoveSquare =
                state.legalMoves.contains(piecePosition.square);

            final isKing = piecePosition != null &&
                piecePosition.pieceInfo.type == PieceType.king &&
                piecePosition.pieceInfo.color ==
                    state.boardHistory.currentState.movingColor;
            final isCheck = isKing &&
                isSquareUnderAttack(piecePosition.pieceInfo.color,
                    piecePosition.square, state.boardHistory.currentState);
            final isStalemate =
                isKing && state.boardHistory.currentState.isStalemate();
            final isCheckmate =
                isKing && state.boardHistory.currentState.isCheckmate();

            final border = Border.all(
              color: piecePosition != null && isLegalMoveSquare
                  ? Colors.redAccent.withOpacity(0.7)
                  : piecePosition.square == state.fromSquare ||
                          isLegalMoveSquare
                      ? Colors.greenAccent.withOpacity(0.7)
                      : isCheck
                          ? Colors.redAccent
                          : isStalemate
                              ? Colors.yellowAccent.withOpacity(.7)
                              : Colors.transparent,
              width: 2,
            );

            final left = state.focusSide == PieceColor.white
                ? screenWidth * piecePosition.square.fileIndex / 8
                : screenWidth -
                    (screenWidth * (piecePosition.square.fileIndex + 1) / 8);
            final bottom = state.focusSide == PieceColor.white
                ? screenWidth * piecePosition.square.rankIndex / 8
                : screenWidth -
                    (screenWidth * (piecePosition.square.rankIndex + 1) / 8);

            return AnimatedPositioned(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 500),
              left: left,
              bottom: bottom,
              key: Key(piecePosition.pieceInfo.id + state.focusSide.toString()),
              child: GestureDetector(
                onTap: context
                    .read(roomBlockProvider)
                    .onSquareTap(piecePosition.square, context),
                child: Container(
                  width: screenWidth / 8,
                  height: screenWidth / 8,
                  decoration: BoxDecoration(
                    color: isCheckmate
                        ? Colors.redAccent.withOpacity(0.8)
                        : isStalemate
                            ? Colors.yellowAccent.withOpacity(0.8)
                            : state.fromSquare == piecePosition.square
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
