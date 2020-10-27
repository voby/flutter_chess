import 'package:flutter_chess/engine/board_init_state.dart';
import 'package:flutter_chess/engine/enums.dart';
import 'package:flutter_chess/engine/square.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Init state', () {
    test('moving color is white', () {
      expect(initBoardState.movingColor, PieceColor.white);
    });
    test('legal moves for e2', () {
      expect(initBoardState.getLegalMoves(Square(File.e, Rank.second)), [
        Square(File.e, Rank.third),
        Square(File.e, Rank.fourth),
      ]);
    });
    test('legal moves for b1', () {
      expect(initBoardState.getLegalMoves(Square(File.b, Rank.first)), [
        Square(File.c, Rank.third),
        Square(File.a, Rank.third),
      ]);
    });
    test('legal moves for g1', () {
      expect(initBoardState.getLegalMoves(Square(File.g, Rank.first)), [
        Square(File.h, Rank.third),
        Square(File.f, Rank.third),
      ]);
    });
    test('legal moves for a1', () {
      expect(initBoardState.getLegalMoves(Square(File.a, Rank.first)), []);
    });
    test('legal moves for c1', () {
      expect(initBoardState.getLegalMoves(Square(File.c, Rank.first)), []);
    });
    test('legal moves for d1', () {
      expect(initBoardState.getLegalMoves(Square(File.d, Rank.first)), []);
    });
    test('legal moves for e1', () {
      expect(initBoardState.getLegalMoves(Square(File.e, Rank.first)), []);
    });
    test('legal moves for f1', () {
      expect(initBoardState.getLegalMoves(Square(File.f, Rank.first)), []);
    });
    test('legal moves for h1', () {
      expect(initBoardState.getLegalMoves(Square(File.h, Rank.first)), []);
    });
  });
}
