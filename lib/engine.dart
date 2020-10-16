enum PieceColor { black, white }
enum PieceType { king, queen, rook, bishop, knight, pawn }
enum Rank { a, b, c, d, e, f, g, h }
enum File { first, second, third, fourth, fifth, sixth, seventh, eighth }

class Move {
  final Square from;
  final Square to;

  Move(this.from, this.to);
}

class Square {
  final Rank rank;
  final File file;

  const Square(this.rank, this.file);
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

  getPosition(int fileIndex, int rankIndex) {
    final file = File.values[fileIndex];
    final rank = Rank.values[rankIndex];

    return piecePositions.firstWhere(
      (position) =>
          position.square.file == file && position.square.rank == rank,
      orElse: () => null,
    );
  }
}

class BoardHistory {
  final List<BoardState> boardStates;

  BoardHistory(initBoardState) : boardStates = [initBoardState];
}
