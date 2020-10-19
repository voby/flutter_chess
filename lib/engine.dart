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
  File file;
  Rank rank;

  Square(this.file, this.rank);

  Square.fromIndexes(int fileIndex, int rankIndex) {
    file = File.values[fileIndex];
    rank = Rank.values[rankIndex];
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

class PiecePosition {
  final Square square;
  final PieceInfo pieceInfo;

  PiecePosition(this.square, this.pieceInfo);
}

class BoardState {
  final List<PiecePosition> piecePositions;

  BoardState(this.piecePositions);

  getPiecePosition(Square square) {
    return piecePositions.firstWhere(
      (position) => position.square == square,
      orElse: () => null,
    );
  }
}

class BoardHistory {
  final List<BoardState> boardStates;

  BoardHistory(initBoardState) : boardStates = [initBoardState];
}

List<Square> getValidMoves(PiecePosition position, BoardState state) {
  return [
    Square(File.d, Rank.fourth),
  ];
}
