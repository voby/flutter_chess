import 'package:equatable/equatable.dart';

enum PieceColor { black, white }
enum PieceType { king, queen, rook, bishop, knight, pawn }
enum File { a, b, c, d, e, f, g, h }
enum Rank { first, second, third, fourth, fifth, sixth, seventh, eighth }

class Move {
  final Square from;
  final Square to;

  Move(this.from, this.to);
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
  final List<PiecePosition> piecePositions;

  BoardState(this.piecePositions);

  PiecePosition getPiecePosition(Square square) {
    return piecePositions.firstWhere(
      (position) => position.square == square,
      orElse: () => null,
    );
  }
}

class BoardHistory {
  final List<BoardState> boardStates;

  BoardHistory(initBoardState) : boardStates = [initBoardState];

  void addState(BoardState state) {
    boardStates.add(state);
  }

  BoardState getState() {
    return boardStates.last;
  }
}
