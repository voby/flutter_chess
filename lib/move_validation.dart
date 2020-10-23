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

      // TODO: castle
      // The castling must be kingside or queenside.[5]
      // Neither the king nor the chosen rook has previously moved.
      // There are no pieces between the king and the chosen rook.
      // The king is not currently in check.
      // The king does not pass through a square that is attacked by an enemy piece.
      // The king does not end up in check. (True of any legal move.)ing doesnt move, rook_a or rook_h doesnt move, no pieces in between
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

List<Square> getValidMoves(Square fromSquare, BoardState state) {
  final position = state.getPiecePosition(fromSquare);
  final allSquares = _getPieceMoves(position, state);
  final legalSquares = List<Square>.from(allSquares.where((toSquare) {
    return toSquare != null &&
        (state.getPiecePosition(toSquare) == null ||
            state.getPiecePosition(toSquare).pieceInfo.color !=
                position.pieceInfo.color);
  }).where((toSquare) => !checkCheck(
      position.pieceInfo.color, state.addMove(fromSquare, toSquare))));

  return legalSquares;
}

Square getOffsetSquare(Square square,
    {int fileOffset = 0, int rankOffset = 0}) {
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

List<Square> getOffsetSquareSeq(BoardState state, Square square,
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

bool checkCheck(PieceColor color, BoardState state) {
  final kingPosition = state.piecePositions.firstWhere((position) =>
      position.pieceInfo.type == PieceType.king &&
      position.pieceInfo.color == color);

  final List<Square> knightSquares = [
    getOffsetSquare(kingPosition.square, fileOffset: 1, rankOffset: 2),
    getOffsetSquare(kingPosition.square, fileOffset: 2, rankOffset: 1),
    getOffsetSquare(kingPosition.square, fileOffset: 2, rankOffset: -1),
    getOffsetSquare(kingPosition.square, fileOffset: 1, rankOffset: -2),
    getOffsetSquare(kingPosition.square, fileOffset: -1, rankOffset: -2),
    getOffsetSquare(kingPosition.square, fileOffset: -2, rankOffset: -1),
    getOffsetSquare(kingPosition.square, fileOffset: -2, rankOffset: 1),
    getOffsetSquare(kingPosition.square, fileOffset: -1, rankOffset: 2),
  ];

  final isKnightAttack = knightSquares.any((square) {
    final position = state.getPiecePosition(square);

    return position != null &&
        position.pieceInfo.type == PieceType.knight &&
        position.pieceInfo.color != color;
  });

  final List<Square> rookSquares = [
    ...getOffsetSquareSeq(state, kingPosition.square, fileOffset: 1),
    ...getOffsetSquareSeq(state, kingPosition.square, fileOffset: -1),
    ...getOffsetSquareSeq(state, kingPosition.square, rankOffset: -1),
    ...getOffsetSquareSeq(state, kingPosition.square, rankOffset: 1),
  ];

  final isRookQueenAttack = rookSquares.any((square) {
    final position = state.getPiecePosition(square);

    return position != null &&
        [PieceType.rook, PieceType.queen].contains(position.pieceInfo.type) &&
        position.pieceInfo.color != color;
  });

  final List<Square> bishopSquares = [
    ...getOffsetSquareSeq(state, kingPosition.square,
        fileOffset: 1, rankOffset: 1),
    ...getOffsetSquareSeq(state, kingPosition.square,
        fileOffset: -1, rankOffset: -1),
    ...getOffsetSquareSeq(state, kingPosition.square,
        fileOffset: 1, rankOffset: -1),
    ...getOffsetSquareSeq(state, kingPosition.square,
        fileOffset: -1, rankOffset: 1),
  ];

  final isBishopQueenAttack = bishopSquares.any((square) {
    final position = state.getPiecePosition(square);

    return position != null &&
        [PieceType.bishop, PieceType.queen].contains(position.pieceInfo.type) &&
        position.pieceInfo.color != color;
  });

  final List<Square> pawnSquares = [
    if (kingPosition.pieceInfo.color == PieceColor.white)
      getOffsetSquare(kingPosition.square, fileOffset: 1, rankOffset: 1),
    if (kingPosition.pieceInfo.color == PieceColor.white)
      getOffsetSquare(kingPosition.square, fileOffset: -1, rankOffset: 1),
    if (kingPosition.pieceInfo.color == PieceColor.black)
      getOffsetSquare(kingPosition.square, fileOffset: 1, rankOffset: -1),
    if (kingPosition.pieceInfo.color == PieceColor.black)
      getOffsetSquare(kingPosition.square, fileOffset: -1, rankOffset: -1),
  ];

  final isPawnAttack = pawnSquares.any((square) {
    final position = state.getPiecePosition(square);

    return position != null &&
        [PieceType.pawn].contains(position.pieceInfo.type) &&
        position.pieceInfo.color != color;
  });

  return isPawnAttack ||
      isKnightAttack ||
      isRookQueenAttack ||
      isBishopQueenAttack;
}

bool checkCheckMate(PieceColor color, BoardState state) {
  final allPositions = state.piecePositions
      .where((position) => position.pieceInfo.color == color);

  for (final position in allPositions) {
    final validMoves = getValidMoves(position.square, state);

    if (validMoves.isNotEmpty) {
      return false;
    }
  }

  return true;
}
