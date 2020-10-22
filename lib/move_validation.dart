import 'engine.dart';

List<Square> _getPieceMoves(PiecePosition position, BoardState state) {
  if (position.pieceInfo.type == PieceType.pawn) {
    if (position.pieceInfo.color == PieceColor.white) {
      final topSquare = getOffsetSquare(position.square, rankOffset: 1);
      final topPosition = state.getPiecePosition(topSquare);
      final topLeftSquare =
          getOffsetSquare(position.square, fileOffset: -1, rankOffset: 1);
      final topLeftPosition = state.getPiecePosition(topLeftSquare);
      final topRightSquare =
          getOffsetSquare(position.square, fileOffset: 1, rankOffset: 1);
      final topRightPosition = state.getPiecePosition(topRightSquare);
      final topTopSquare = getOffsetSquare(position.square, rankOffset: 2);
      final topTopPosition = state.getPiecePosition(topTopSquare);
      final List<Square> squares = [
        if (topPosition == null) topSquare,
        if (topLeftPosition != null &&
            topLeftPosition.pieceInfo.color != position.pieceInfo.color)
          topLeftSquare,
        if (topRightPosition != null &&
            topRightPosition.pieceInfo.color != position.pieceInfo.color)
          topRightSquare,
        if (position.square.rank == Rank.second && topTopPosition == null)
          topTopSquare,
      ];

      return squares;
    }

    final topSquare = getOffsetSquare(position.square, rankOffset: -1);
    final topPosition = state.getPiecePosition(topSquare);
    final topLeftSquare =
        getOffsetSquare(position.square, fileOffset: -1, rankOffset: -1);
    final topLeftPosition = state.getPiecePosition(topLeftSquare);
    final topRightSquare =
        getOffsetSquare(position.square, fileOffset: 1, rankOffset: -1);
    final topRightPosition = state.getPiecePosition(topRightSquare);
    final topTopSquare = getOffsetSquare(position.square, rankOffset: -2);
    final topTopPosition = state.getPiecePosition(topTopSquare);
    final List<Square> squares = [
      if (topPosition == null) topSquare,
      if (topLeftPosition != null &&
          topLeftPosition.pieceInfo.color != position.pieceInfo.color)
        topLeftSquare,
      if (topRightPosition != null &&
          topRightPosition.pieceInfo.color != position.pieceInfo.color)
        topRightSquare,
      if (position.square.rank == Rank.seventh && topTopPosition == null)
        topTopSquare,
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
      ...getOffsetSquareSeq(state, position.square, fileOffset: 1),
      ...getOffsetSquareSeq(state, position.square, fileOffset: -1),
      ...getOffsetSquareSeq(state, position.square, rankOffset: -1),
      ...getOffsetSquareSeq(state, position.square, rankOffset: 1),
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.bishop) {
    final List<Square> squares = [
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: 1, rankOffset: 1),
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: -1, rankOffset: -1),
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: 1, rankOffset: -1),
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: -1, rankOffset: 1),
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.queen) {
    final List<Square> squares = [
      ...getOffsetSquareSeq(state, position.square, fileOffset: 1),
      ...getOffsetSquareSeq(state, position.square, fileOffset: -1),
      ...getOffsetSquareSeq(state, position.square, rankOffset: -1),
      ...getOffsetSquareSeq(state, position.square, rankOffset: 1),
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: 1, rankOffset: 1),
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: -1, rankOffset: -1),
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: 1, rankOffset: -1),
      ...getOffsetSquareSeq(state, position.square,
          fileOffset: -1, rankOffset: 1),
    ];

    return squares;
  }

  return [];
}

List<Square> getValidMoves(PiecePosition position, BoardState state) {
  final List<Square> squares = _getPieceMoves(position, state);

  return squares
      .where((square) =>
          square != null &&
          (state.getPiecePosition(square) == null ||
              state.getPiecePosition(square).pieceInfo.color !=
                  position.pieceInfo.color))
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

getOffsetSquareSeq(BoardState state, Square square,
    {int fileOffset = 0, int rankOffset = 0}) {
  bool isWhile = true;
  final startPosition = state.getPiecePosition(square);
  final List<Square> squares = [];
  final List<Square> possibleSquares = List.generate(
    8,
    (index) => getOffsetSquare(
      square,
      fileOffset: fileOffset == 0 ? 0 : index * fileOffset + fileOffset,
      rankOffset: rankOffset == 0 ? 0 : index * rankOffset + rankOffset,
    ),
  );

  for (Square s in possibleSquares) {
    if (isWhile) {
      final endPosition = state.getPiecePosition(s);

      if (endPosition == null) {
        squares.add(s);
      } else if (endPosition.pieceInfo.color != startPosition.pieceInfo.color) {
        squares.add(s);
        isWhile = false;
      } else {
        isWhile = false;
      }
    }
  }

  return squares;
}
