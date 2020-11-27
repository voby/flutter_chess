import 'package:flutter/material.dart';

import 'engine/enums.dart';

class BoardLayer extends StatelessWidget {
  const BoardLayer({
    Key key,
    @required this.focusSide,
  }) : super(key: key);

  final PieceColor focusSide;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: screenWidth,
      child: Row(
        children: buildFiles(context),
      ),
    );
  }

  List<Widget> buildFiles(BuildContext context) {
    final seed = focusSide == PieceColor.white
        ? List.generate(8, (i) => i)
        : List.generate(8, (i) => i).reversed;

    return seed.map((fileIndex) {
      return Flexible(
        child: Column(
          children: buildSquares(context, fileIndex),
        ),
      );
    }).toList();
  }

  List<Widget> buildSquares(BuildContext context, int fileIndex) {
    final seed = focusSide == PieceColor.white
        ? List.generate(8, (i) => i).reversed
        : List.generate(8, (i) => i);

    return seed.map((rankIndex) {
      final size = MediaQuery.of(context).size.width / 8;
      final squareColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown : Colors.brown[100];
      final numberColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown[100] : Colors.brown;

      return Container(
        color: squareColor,
        width: size,
        height: size,
        child: Stack(
          children: [
            if (focusSide == PieceColor.white ? fileIndex == 7 : fileIndex == 0)
              Positioned(
                top: 1,
                right: 1,
                child: Text(
                  (rankIndex + 1).toString(),
                  style: TextStyle(
                    color: numberColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (focusSide == PieceColor.white ? rankIndex == 0 : rankIndex == 7)
              Positioned(
                bottom: 1,
                left: 1,
                child: Text(
                  File.values[fileIndex].toString().split('.').last,
                  style: TextStyle(
                    color: numberColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      );
    }).toList();
  }
}
