import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'engine/enums.dart';
import 'room.dart';

class LegalMovesLayer extends ConsumerWidget {
  const LegalMovesLayer({
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
          ...state.boardHistory.currentState
              .getLegalMoves(state.fromSquare)
              .map(
            (square) {
              final left = state.focusSide == PieceColor.white
                  ? screenWidth * square.fileIndex / 8
                  : null;
              final bottom = state.focusSide == PieceColor.white
                  ? screenWidth * square.rankIndex / 8
                  : null;
              final right = state.focusSide != PieceColor.white
                  ? screenWidth * square.fileIndex / 8
                  : null;
              final top = state.focusSide != PieceColor.white
                  ? screenWidth * square.rankIndex / 8
                  : null;

              return Positioned(
                left: left,
                bottom: bottom,
                right: right,
                top: top,
                child: GestureDetector(
                  onTap: () {
                    context
                        .read(roomBlockProvider)
                        .completeMove(square, context);
                  },
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
