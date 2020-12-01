import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'engine/enums.dart';
import 'room.dart';
import 'room_state.dart';

class BoardLayer extends ConsumerWidget {
  const BoardLayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(roomBlockProvider.state);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: screenWidth,
      child: Row(
        children: buildFiles(context, state),
      ),
    );
  }

  List<Widget> buildFiles(BuildContext context, RoomState state) {
    final seed = state.focusSide == PieceColor.white
        ? List.generate(8, (i) => i)
        : List.generate(8, (i) => i).reversed;

    return seed.map((fileIndex) {
      return Flexible(
        child: Column(
          children: buildSquares(context, fileIndex, state),
        ),
      );
    }).toList();
  }

  List<Widget> buildSquares(
      BuildContext context, int fileIndex, RoomState state) {
    final seed = state.focusSide == PieceColor.white
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
            if (state.focusSide == PieceColor.white
                ? fileIndex == 7
                : fileIndex == 0)
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
            if (state.focusSide == PieceColor.white
                ? rankIndex == 0
                : rankIndex == 7)
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
