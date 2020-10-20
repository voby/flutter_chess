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

  addState(BoardState state) {
    boardStates.add(state);
  }
}

List<Square> _getPieceMoves(PiecePosition position, BoardState state) {
  if (position.pieceInfo.type == PieceType.pawn) {
    final List<Square> squares = [
      getOffsetSquare(position.square, rankOffset: 1),
      if (position.square.rank == Rank.second)
        getOffsetSquare(position.square, rankOffset: 2),
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.king) {
    final List<Square> squares = [
      getOffsetSquare(position.square, fileOffset: 0, rankOffset: 1),
      getOffsetSquare(position.square, fileOffset: 1, rankOffset: 1),
      getOffsetSquare(position.square, fileOffset: 1, rankOffset: 0),
      getOffsetSquare(position.square, fileOffset: 1, rankOffset: -1),
      getOffsetSquare(position.square, fileOffset: 0, rankOffset: -1),
      getOffsetSquare(position.square, fileOffset: -1, rankOffset: -1),
      getOffsetSquare(position.square, fileOffset: -1, rankOffset: 0),
      getOffsetSquare(position.square, fileOffset: -1, rankOffset: 1),
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.knight) {
    final List<Square> squares = [
      getOffsetSquare(position.square, fileOffset: 1, rankOffset: 2),
      getOffsetSquare(position.square, fileOffset: 2, rankOffset: 1),
      getOffsetSquare(position.square, fileOffset: 2, rankOffset: -1),
      getOffsetSquare(position.square, fileOffset: 1, rankOffset: -2),
      getOffsetSquare(position.square, fileOffset: -1, rankOffset: -2),
      getOffsetSquare(position.square, fileOffset: -2, rankOffset: -1),
      getOffsetSquare(position.square, fileOffset: -2, rankOffset: 1),
      getOffsetSquare(position.square, fileOffset: -1, rankOffset: 2),
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.rook) {
    final List<Square> squares = [
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, fileOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, fileOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, rankOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, rankOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.bishop) {
    final List<Square> squares = [
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: index + 1, rankOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: -index - 1, rankOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: -index - 1, rankOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: index + 1, rankOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.queen) {
    final List<Square> squares = [
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, fileOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, fileOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, rankOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) =>
                  getOffsetSquare(position.square, rankOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: index + 1, rankOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: -index - 1, rankOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: -index - 1, rankOffset: index + 1))
          .takeWhile((square) => state.getPiecePosition(square) == null),
      ...List.generate(
              8,
              (index) => getOffsetSquare(position.square,
                  fileOffset: index + 1, rankOffset: -index - 1),
              growable: false)
          .takeWhile((square) => state.getPiecePosition(square) == null),
    ];

    return squares;
  }

  return [];
}

List<Square> getValidMoves(PiecePosition position, BoardState state) {
  final List<Square> squares = _getPieceMoves(position, state);

  return squares
      .where(
          (square) => square != null && state.getPiecePosition(square) == null)
      .toList();
}

getOffsetSquare(Square square, {int fileOffset = 0, int rankOffset = 0}) {
  final fileIndex = File.values.indexOf(square.file) + fileOffset;
  final rankIndex = Rank.values.indexOf(square.rank) + rankOffset;

  if (0 > fileIndex || fileIndex > 7 || 0 > rankIndex || rankIndex > 7) {
    return null;
  }

  return Square(
    File.values[fileIndex],
    Rank.values[rankIndex],
  );
}
