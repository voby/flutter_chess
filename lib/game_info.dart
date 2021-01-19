import 'package:flutter/material.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            PlayerInfo(),
            GameScore(),
            PlayerInfo(),
          ],
        ),
      ),
    );
  }
}

class GameScore extends StatelessWidget {
  const GameScore({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.green.withOpacity(0.3),
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 5),
        Container(
          color: Colors.green.withOpacity(0.3),
          width: 100,
          height: 20,
        ),
      ],
    );
  }
}
