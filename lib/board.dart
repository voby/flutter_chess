import 'package:flutter/material.dart';

import 'board_controls.dart';
import 'engine/board_history.dart';
import 'engine/board_init_state.dart';
import 'engine/enums.dart';
import 'engine/move_validation.dart';
import 'engine/piece_position.dart';
import 'engine/square.dart';
import 'piece.dart';

class Board extends StatefulWidget {
  const Board({
    Key key,
  }) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  BoardHistory boardHistory;
  Square fromSquare;
  List<Square> legalMoves = [];

  List<Widget> get getFiles {
    return List.generate(8, (i) => i).map((fileIndex) {
      return Flexible(
        child: Column(
          children: getSquares(fileIndex),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenWidth,
            child: Row(
              children: getFiles,
            ),
          ),
          BoardControls(
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

  void setPrevState() {
    setState(() {
      boardHistory = boardHistory.setPrevState();
    });
  }

  void setNextState() {
    setState(() {
      boardHistory = boardHistory.setNextState();
    });
  }

  void cancelMove() {
    setState(() {
      fromSquare = null;
      legalMoves = [];
    });
  }

  void completeMove(Square toSquare) {
    final newState = boardHistory.currentState.addMove(fromSquare, toSquare);

    setState(() {
      boardHistory = boardHistory.addState(newState);
      fromSquare = null;
      legalMoves = [];
    });
  }

  List<Widget> getSquares(int fileIndex) {
    return List.generate(8, (i) => i).reversed.map((rankIndex) {
      final square = Square.fromIndexes(fileIndex, rankIndex);
      final squareColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown : Colors.brown[100];
      final PiecePosition piecePosition =
          boardHistory.currentState.getPiecePosition(square);

      final isLegalMoveSquare = legalMoves.contains(square);

      final isKing = piecePosition != null &&
          piecePosition.pieceInfo.type == PieceType.king &&
          piecePosition.pieceInfo.color ==
              boardHistory.currentState.movingColor;
      final isCheck = isKing &&
          isSquareUnderAttack(
              piecePosition.pieceInfo.color, square, boardHistory.currentState);
      final isStalemate = isKing && boardHistory.currentState.isStalemate();
      final isCheckmate = isKing && boardHistory.currentState.isCheckmate();

      return Flexible(
        child: GestureDetector(
          onTap: onSquareTap(square, piecePosition),
          child: Container(
            child: piecePosition != null
                ? Piece(
                    pieceInfo: piecePosition.pieceInfo,
                  )
                : SizedBox.expand(),
            decoration: BoxDecoration(
              color: isLegalMoveSquare
                  ? piecePosition != null
                      ? Colors.redAccent
                      : Colors.purpleAccent[100]
                  : isCheckmate
                      ? Colors.redAccent
                      : isStalemate
                          ? Colors.yellowAccent
                          : squareColor,
              border: Border.all(
                  color: square == fromSquare
                      ? Colors.greenAccent
                      : isCheck
                          ? Colors.redAccent
                          : Colors.transparent,
                  width: 2),
            ),
          ),
        ),
      );
    }).toList();
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
    boardHistory = BoardHistory([initBoardState]);
  }

  Function onSquareTap(Square square, PiecePosition piecePosition) {
    return () {
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
    print('Restarting game...');
    setState(() {
      fromSquare = null;
      legalMoves = [];
      boardHistory = boardHistory.resetState();
    });
  }
}
