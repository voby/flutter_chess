import 'package:flutter/material.dart';

class BoardControls extends StatelessWidget {
  final Function restartGame;

  const BoardControls({
    Key key,
    this.restartGame,
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
            child: Icon(Icons.menu, color: Colors.white),
          ),
          Icon(Icons.swap_calls, color: Colors.white),
          Icon(Icons.arrow_back, color: Colors.white),
          Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    );
  }
}
