import 'package:flutter_chess/engine/board_history.dart';
import 'package:flutter_chess/engine/board_init_state.dart';
import 'package:flutter_chess/engine/enums.dart';
import 'package:flutter_chess/engine/square.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final history0 = BoardHistory([initBoardState]);

  group('Initial state', () {
    test('current state is the latest state', () {
      expect(history0.currentState, initBoardState);
    });
    test('no prev state', () {
      expect(history0.hasPrevState, false);
    });
    test('no next state', () {
      expect(history0.hasNextState, false);
    });
  });

  final state1 = history0.currentState
      .addMove(Square(File.e, Rank.second), Square(File.e, Rank.fourth));
  final history1 = history0.addState(state1);

  group('After e2e4', () {
    test('current state is the latest state', () {
      expect(history1.currentState, state1);
    });
    test('has prev state', () {
      expect(history1.hasPrevState, true);
    });
    test('no next state', () {
      expect(history1.hasNextState, false);
    });
  });

  final history2 = history1.setPrevState();

  group('After set prev state', () {
    test('current state is the first state', () {
      expect(history2.currentState, initBoardState);
    });
    test('no prev state', () {
      expect(history2.hasPrevState, false);
    });
    test('has next state', () {
      expect(history2.hasNextState, true);
    });
  });

  final history3 = history2.setNextState();

  group('After set next state', () {
    test('current state is the latest state', () {
      expect(history3.currentState, state1);
    });
    test('has prev state', () {
      expect(history3.hasPrevState, true);
    });
    test('no next state', () {
      expect(history3.hasNextState, false);
    });
  });
}
