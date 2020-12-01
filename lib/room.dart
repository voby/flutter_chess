import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import 'board_controls.dart';
import 'board_layer.dart';
import 'legal_moves_layer.dart';
import 'piece_layer.dart';
import 'room_bloc.dart';

final roomBlockProvider = StateNotifierProvider((_) => RoomBloc());

class Room extends StatelessWidget {
  const Room({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: const [
              BoardLayer(),
              LegalMovesLayer(),
              PieceLayer(),
            ],
          ),
          const BoardControls(),
        ],
      ),
    );
  }
}
