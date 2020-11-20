import 'package:flutter/material.dart';

class BoardControls extends StatelessWidget {
  final VoidCallback rotateBoard;
  final bool hasRestartGame;
  final VoidCallback restartGame;
  final bool hasNextState;
  final VoidCallback setNextState;
  final bool hasPrevState;
  final VoidCallback setPrevState;

  const BoardControls({
    Key key,
    this.rotateBoard,
    this.hasRestartGame,
    this.restartGame,
    this.hasNextState,
    this.hasPrevState,
    this.setNextState,
    this.setPrevState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: restartGame,
            child: Icon(
              Icons.menu,
              color: hasRestartGame ? Colors.white : Colors.white38,
            ),
          ),
          InkWell(
            onTap: rotateBoard,
            child: const Icon(Icons.swap_calls, color: Colors.white),
          ),
          InkWell(
            onTap: setPrevState,
            child: Icon(
              Icons.arrow_back,
              color: hasPrevState ? Colors.white : Colors.white38,
            ),
          ),
          InkWell(
            onTap: setNextState,
            child: Icon(
              Icons.arrow_forward,
              color: hasNextState ? Colors.white : Colors.white38,
            ),
          ),
        ],
      ),
    );
  }
}
