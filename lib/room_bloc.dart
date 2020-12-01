import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import 'engine/board_history.dart';
import 'engine/board_init_state.dart';
import 'engine/enums.dart';
import 'engine/move_validation.dart';
import 'engine/piece_info.dart';
import 'engine/square.dart';
import 'piece.dart';
import 'room_state.dart';

class RoomBloc extends StateNotifier<RoomState> {
  RoomBloc()
      : super(RoomState(boardHistory: const BoardHistory([initBoardState])));

  void cancelMove() {
    state = state.copyWith(
      fromSquare: Nullable(null),
      legalMoves: [],
    );
  }

  void completeMove(Square toSquare, BuildContext context) {
    final fromPosition =
        state.boardHistory.currentState.getPiecePosition(state.fromSquare);
    final isPromotion = fromPosition.pieceInfo.type == PieceType.pawn &&
        [Rank.first, Rank.eighth].contains(toSquare.rank);

    if (isPromotion) {
      print('Promotion');
      showModalBottomSheet<Widget>(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PieceType.queen,
                  PieceType.knight,
                  PieceType.bishop,
                  PieceType.rook
                ]
                    .map(
                      (pieceType) => InkWell(
                        onTap: () {
                          _completeMove(toSquare, pieceType);
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Piece(
                            pieceInfo: PieceInfo(
                              'id',
                              fromPosition.pieceInfo.color,
                              pieceType,
                            ),
                            // Colors.green,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          });
    } else {
      _completeMove(toSquare);
    }
  }

  void _completeMove(Square toSquare, [PieceType promotionPiece]) {
    final newState = state.boardHistory.currentState
        .addMove(state.fromSquare, toSquare, promotionPiece: promotionPiece);

    state = state.copyWith(
      boardHistory: state.boardHistory.addState(newState),
      fromSquare: Nullable(null),
      legalMoves: [],
    );
  }

  void initMove(Square square) {
    state = state.copyWith(
      fromSquare: Nullable(square),
      legalMoves: getValidMoves(square, state.boardHistory.currentState),
    );
  }

  void Function() onSquareTap(Square square, BuildContext context) {
    return () {
      final piecePosition =
          state.boardHistory.currentState.getPiecePosition(square);

      if (piecePosition != null &&
          piecePosition.pieceInfo.color ==
              state.boardHistory.currentState.movingColor) {
        if (state.fromSquare != square) {
          initMove(square);
        } else {
          cancelMove();
        }
      } else if (state.legalMoves.contains(square)) {
        completeMove(square, context);
      }
    };
  }

  void restartGame() {
    if (state.boardHistory.hasResetState) {
      state = state.copyWith(
        fromSquare: Nullable(null),
        legalMoves: [],
        boardHistory: state.boardHistory.resetState(),
      );
    }
  }

  void rotateBoard() {
    state = state.copyWith(
      focusSide: state.focusSide == PieceColor.white
          ? PieceColor.black
          : PieceColor.white,
    );
  }

  void setPrevState() {
    if (state.boardHistory.hasPrevState) {
      state = state.copyWith(
        fromSquare: Nullable(null),
        legalMoves: [],
        boardHistory: state.boardHistory.setPrevState(),
      );
    }
  }

  void setNextState() {
    if (state.boardHistory.hasNextState) {
      state = state.copyWith(
        fromSquare: Nullable(null),
        legalMoves: [],
        boardHistory: state.boardHistory.setNextState(),
      );
    }
  }
}
