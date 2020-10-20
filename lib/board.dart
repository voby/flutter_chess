import 'package:flutter/material.dart';
import 'package:flutter_chess/init_board_state.dart';

import 'engine.dart';
import 'init_board_state.dart';
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
  BoardState boardState;
  PieceColor side = PieceColor.white;
  Square fromSquare;
  List<Square> validMoves = [];

  @override
  void initState() {
    super.initState();
    boardHistory = BoardHistory(initBoardState);
    boardState = boardHistory.boardStates.last;
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

  final iter = List<int>.generate(8, (i) => i);

  List<Widget> get getFiles {
    return iter.map((fileIndex) {
      return Flexible(
        child: Column(
          children: getSquares(fileIndex),
        ),
      );
    }).toList();
  }

  List<Widget> getSquares(int fileIndex) {
    return iter.reversed.map((rankIndex) {
      final square = Square.fromIndexes(fileIndex, rankIndex);
      final squareColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown : Colors.brown[100];
      final PiecePosition piecePosition = boardState.getPiecePosition(square);

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
              color: isValidMoveSquare ? Colors.purpleAccent[100] : squareColor,
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
      setState(() {
        if (piecePosition != null && piecePosition.pieceInfo.color == side) {
          fromSquare = square;
          validMoves = getValidMoves(piecePosition, boardState);
        } else if (fromSquare != null && validMoves.contains(square)) {
          final fromPosition = boardState.getPiecePosition(fromSquare);
          if (fromPosition != null) {
            List<PiecePosition> piecePositions = boardState.piecePositions
              ..removeWhere((position) => position == fromPosition)
              ..add(PiecePosition(square, fromPosition.pieceInfo));

            final nextState = BoardState(piecePositions);
            boardHistory.addState(nextState);
            boardState = nextState;
            fromSquare = null;
            validMoves = [];
          }
        }
      });
    };
  }
}
