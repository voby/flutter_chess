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
    return iter.map((value) {
      return Flexible(
        child: Column(
          children: getSquares(value),
        ),
      );
    }).toList();
  }

  List<Widget> getSquares(int rankIndex) {
    return iter.reversed.toList().map((fileIndex) {
      final squareColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown[100] : Colors.brown;
      final PiecePosition piecePosition =
          boardState.getPosition(fileIndex, rankIndex);

      return Flexible(
        child: Container(
          child: piecePosition != null
              ? Piece(
                  pieceInfo: piecePosition.pieceInfo,
                )
              : SizedBox.expand(),
          color: squareColor,
        ),
      );
    }).toList();
  }
}
