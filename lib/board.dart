import 'package:flutter/material.dart';

import 'board_controls.dart';
import 'board_layer.dart';
import 'engine/board_history.dart';
import 'engine/board_init_state.dart';
import 'engine/enums.dart';
import 'engine/move_validation.dart';
import 'engine/piece_info.dart';
import 'engine/square.dart';
import 'legal_moves_layer.dart';
import 'piece.dart';
import 'piece_layer.dart';

class Room extends StatefulWidget {
  const Room({
    Key key,
  }) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  BoardHistory boardHistory;
  Square fromSquare;
  List<Square> legalMoves = [];
  PieceColor focusSide = PieceColor.white;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              BoardLayer(focusSide: focusSide),
              LegalMovesLayer(
                screenWidth: screenWidth,
                focusSide: focusSide,
                boardHistory: boardHistory,
                legalMoves: legalMoves,
                fromSquare: fromSquare,
                onSquareTap: onSquareTap,
              ),
              PieceLayer(
                screenWidth: screenWidth,
                focusSide: focusSide,
                boardHistory: boardHistory,
                legalMoves: legalMoves,
                fromSquare: fromSquare,
                onSquareTap: onSquareTap,
              ),
            ],
          ),
          BoardControls(
            rotateBoard: rotateBoard,
            hasRestartGame: boardHistory.hasResetState,
            restartGame: restartGame,
            hasNextState: boardHistory.hasNextState,
            setNextState: setNextState,
            hasPrevState: boardHistory.hasPrevState,
            setPrevState: setPrevState,
          ),
        ],
      ),
    );
  }

  void cancelMove() {
    setState(() {
      fromSquare = null;
      legalMoves = [];
    });
  }

  void completeMove(Square toSquare) {
    final fromPosition = boardHistory.currentState.getPiecePosition(fromSquare);
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
    final newState = boardHistory.currentState
        .addMove(fromSquare, toSquare, promotionPiece: promotionPiece);

    setState(() {
      boardHistory = boardHistory.addState(newState);
      fromSquare = null;
      legalMoves = [];
    });
  }

  void initMove(Square square) {
    setState(() {
      fromSquare = square;
      legalMoves = getValidMoves(square, boardHistory.currentState);
    });
  }

  @override
  void initState() {
    super.initState();
    boardHistory = const BoardHistory([initBoardState]);
  }

  VoidCallback onSquareTap(Square square) {
    return () {
      final piecePosition = boardHistory.currentState.getPiecePosition(square);

      if (piecePosition != null &&
          piecePosition.pieceInfo.color ==
              boardHistory.currentState.movingColor) {
        if (fromSquare != square) {
          initMove(square);
        } else {
          cancelMove();
        }
      } else if (legalMoves.contains(square)) {
        completeMove(square);
      }
    };
  }

  void restartGame() {
    if (boardHistory.hasResetState) {
      setState(() {
        fromSquare = null;
        legalMoves = [];
        boardHistory = boardHistory.resetState();
      });
    }
  }

  void rotateBoard() {
    setState(() {
      focusSide =
          focusSide == PieceColor.white ? PieceColor.black : PieceColor.white;
    });
  }

  void setPrevState() {
    if (boardHistory.hasPrevState) {
      setState(() {
        fromSquare = null;
        legalMoves = [];
        boardHistory = boardHistory.setPrevState();
      });
    }
  }

  void setNextState() {
    if (boardHistory.hasNextState) {
      fromSquare = null;
      legalMoves = [];
      setState(() {
        boardHistory = boardHistory.setNextState();
      });
    }
  }
}
