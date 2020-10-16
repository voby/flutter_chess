import 'package:flutter/material.dart';
import 'package:flutter_chess/piece.dart';

class Board extends StatefulWidget {
  const Board({
    Key key,
  }) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenWidth,
      child: Column(
        children: getRows,
      ),
    );
  }

  final iter = List<int>.generate(8, (i) => i);

  List<Widget> get getRows {
    return iter.map((value) {
      return Flexible(
        child: Row(
          children: getSquares(value),
        ),
      );
    }).toList();
  }

  List<Widget> getSquares(int rowIndex) {
    return iter.map((value) {
      final squareColor =
          value % 2 == rowIndex % 2 ? Colors.brown[100] : Colors.brown;
      final pieceColor =
          [6, 7].contains(rowIndex) ? PieceColor.white : PieceColor.black;
      final pieceType = getPieceType(rowIndex, value);

      return Flexible(
        child: Container(
          child: [0, 1, 6, 7].contains(rowIndex)
              ? Piece(
                  type: pieceType,
                  color: pieceColor,
                )
              : SizedBox.expand(),
          color: squareColor,
        ),
      );
    }).toList();
  }

  PieceType getPieceType(int rowIndex, int value) {
    if (![1, 6].contains(rowIndex)) {
      if ([0, 7].contains(value)) {
        return PieceType.rook;
      }
      if ([1, 6].contains(value)) {
        return PieceType.knight;
      }
      if ([2, 5].contains(value)) {
        return PieceType.bishop;
      }
      if (value == 3) {
        return PieceType.queen;
      }
      if (value == 4) {
        return PieceType.king;
      }
    }
    return PieceType.pawn;
  }
}
