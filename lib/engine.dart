import 'package:equatable/equatable.dart';
import 'package:flutter_chess/init_board_state.dart';

enum PieceColor { black, white }
enum PieceType { king, queen, rook, bishop, knight, pawn }
enum File { a, b, c, d, e, f, g, h }
enum Rank { first, second, third, fourth, fifth, sixth, seventh, eighth }

class Move {
  final PieceInfo piece;
  final Square from;
  final Square to;

  Move(this.piece, this.from, this.to);
}

class Square extends Equatable {
  final File file;
  final Rank rank;

  Square(this.file, this.rank);

  factory Square.fromIndexes(int fileIndex, int rankIndex) {
    return Square(File.values[fileIndex], Rank.values[rankIndex]);
  }

  @override
  List<Object> get props => [file, rank];
}

class PieceInfo {
  final String id;
  final PieceColor color;
  final PieceType type;

  PieceInfo(this.id, this.color, this.type);
}

class PiecePosition extends Equatable {
  final Square square;
  final PieceInfo pieceInfo;

  PiecePosition(this.square, this.pieceInfo);

  @override
  List<Object> get props => [square];
}

class BoardState {
  final Move _move;
  final List<PiecePosition> _piecePositions;

  BoardState(this._move, this._piecePositions);

  Move get move => _move;
  PieceColor get movingColor => _move.piece.color == PieceColor.white
      ? PieceColor.black
      : PieceColor.white;
  List<PiecePosition> get piecePositions => List.unmodifiable(_piecePositions);

  PiecePosition getPiecePosition(Square square) {
    return _piecePositions.firstWhere(
      (position) => position.square == square,
      orElse: () => null,
    );
  }

  BoardState addMove(Square fromSquare, Square toSquare) {
    final fromPosition = getPiecePosition(fromSquare);
    final toPosition = getPiecePosition(toSquare);
    final move = Move(fromPosition.pieceInfo, fromSquare, toSquare);

    final piecePositions = List<PiecePosition>.from(_piecePositions)
      ..removeWhere((position) => position == fromPosition)
      ..removeWhere((position) => position == toPosition)
      ..add(PiecePosition(toSquare, fromPosition.pieceInfo));

    return BoardState(move, piecePositions);
  }
}

class BoardHistory {
  final List<BoardState> _boardStates;

  BoardHistory(this._boardStates);

  BoardState get currentState => _boardStates.last;

  BoardHistory addState(BoardState state) {
    return BoardHistory([..._boardStates, state]);
  }

  BoardHistory restartGame() {
    return BoardHistory([initBoardState]);
  }
}
