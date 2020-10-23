import 'package:flutter/material.dart';

import 'board_controls.dart';
import 'engine.dart';
import 'init_board_state.dart';
import 'move_validation.dart';
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
  List<Square> validMoves = [];

  @override
  void initState() {
    super.initState();
    boardHistory = BoardHistory([initBoardState]);
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
          BoardControls(restartGame: restartGame),
        ],
      ),
    );
  }

  List<Widget> get getFiles {
    return List.generate(8, (i) => i).map((fileIndex) {
      return Flexible(
        child: Column(
          children: getSquares(fileIndex),
        ),
      );
    }).toList();
  }

  List<Widget> getSquares(int fileIndex) {
    return List.generate(8, (i) => i).reversed.map((rankIndex) {
      final square = Square.fromIndexes(fileIndex, rankIndex);
      final squareColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown : Colors.brown[100];
      final PiecePosition piecePosition =
          boardHistory.currentState.getPiecePosition(square);

      final isValidMoveSquare = validMoves.contains(square);
      final isCheck = piecePosition != null &&
          piecePosition.pieceInfo.type == PieceType.king &&
          checkCheck(piecePosition.pieceInfo.color, boardHistory.currentState);
      final isCheckMate = isCheck &&
          checkCheckMate(
              piecePosition.pieceInfo.color, boardHistory.currentState);

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
              color: isValidMoveSquare
                  ? piecePosition != null
                      ? Colors.redAccent
                      : Colors.purpleAccent[100]
                  : isCheckMate
                      ? Colors.redAccent
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
      } else if (validMoves.contains(square)) {
        completeMove(square);
      }
    };
  }

  void initMove(Square square) {
    setState(() {
      fromSquare = square;
      validMoves = getValidMoves(square, boardHistory.currentState);
    });
  }

  void cancelMove() {
    setState(() {
      fromSquare = null;
      validMoves = [];
    });
  }

  void completeMove(Square toSquare) {
    final newState = boardHistory.currentState.addMove(fromSquare, toSquare);

    setState(() {
      boardHistory = boardHistory.addState(newState);
      fromSquare = null;
      validMoves = [];
    });
  }

  void restartGame() {
    print('Restarting game...');
    setState(() {
      fromSquare = null;
      validMoves = [];
      boardHistory = boardHistory.restartGame();
    });
  }
}
