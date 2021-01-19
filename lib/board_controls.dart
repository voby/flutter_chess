import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'room.dart';

class BoardControls extends ConsumerWidget {
  const BoardControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(roomBlockProvider.state);

    return Container(
      color: Colors.black54,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: context.read(roomBlockProvider).restartGame,
            child: Icon(
              Icons.menu,
              color: state.boardHistory.hasResetState
                  ? Colors.white
                  : Colors.white38,
            ),
          ),
          InkWell(
            onTap: context.read(roomBlockProvider).rotateBoard,
            child: const Icon(Icons.swap_calls, color: Colors.white),
          ),
          InkWell(
            onTap: context.read(roomBlockProvider).setPrevState,
            child: Icon(
              Icons.arrow_back,
              color: state.boardHistory.hasPrevState
                  ? Colors.white
                  : Colors.white38,
            ),
          ),
          InkWell(
            onTap: context.read(roomBlockProvider).setNextState,
            child: Icon(
              Icons.arrow_forward,
              color: state.boardHistory.hasNextState
                  ? Colors.white
                  : Colors.white38,
            ),
          ),
        ],
      ),
    );
  }
}
