import 'package:flutter/material.dart';

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
  PieceColor movingColor = PieceColor.white;
  Square fromSquare;
  List<Square> validMoves = [];

  @override
  void initState() {
    super.initState();
    boardHistory = BoardHistory(initBoardState);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenWidth,
      child: Row(
        children: getFiles,
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
          boardHistory.getState().getPiecePosition(square);

      final isValidMoveSquare = validMoves.contains(square);

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
                  : squareColor,
              border: Border.all(
                  color: square == fromSquare
                      ? Colors.pinkAccent
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
          piecePosition.pieceInfo.color == movingColor) {
        if (fromSquare != square) {
          initMove(square, piecePosition);
        } else {
          cancelMove();
        }
      } else if (validMoves.contains(square)) {
        completeMove(square);
      }
    };
  }

  void initMove(Square square, PiecePosition piecePosition) {
    setState(() {
      fromSquare = square;
      validMoves = getValidMoves(piecePosition, boardHistory.getState());
    });
  }

  void cancelMove() {
    setState(() {
      fromSquare = null;
      validMoves = [];
    });
  }

  void completeMove(Square square) {
    final fromPosition = boardHistory.getState().getPiecePosition(fromSquare);
    final toPosition = boardHistory.getState().getPiecePosition(square);

    List<PiecePosition> piecePositions = boardHistory.getState().piecePositions
      ..removeWhere((position) => position == fromPosition)
      ..removeWhere((position) => position == toPosition)
      ..add(PiecePosition(square, fromPosition.pieceInfo));
    boardHistory.addState(BoardState(piecePositions));

    setState(() {
      fromSquare = null;
      validMoves = [];
      movingColor =
          movingColor == PieceColor.white ? PieceColor.black : PieceColor.white;
    });
  }
}
