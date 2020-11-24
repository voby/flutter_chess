import 'board_state.dart';
import 'enums.dart';
import 'piece_position.dart';
import 'square.dart';

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
      final isEnPassant = position.square.rank == Rank.fifth &&
          state.move.piece.type == PieceType.pawn;
      final isEnPassantLeft = isEnPassant &&
          state.move.from ==
              getOffsetSquare(
                position.square,
                fileOffset: -1,
                rankOffset: 2,
              ) &&
          state.move.to ==
              getOffsetSquare(
                position.square,
                fileOffset: -1,
              );
      final isEnPassantRight = isEnPassant &&
          state.move.from ==
              getOffsetSquare(
                position.square,
                fileOffset: 1,
                rankOffset: 2,
              ) &&
          state.move.to ==
              getOffsetSquare(
                position.square,
                fileOffset: 1,
              );

      final List<Square> squares = [
        if (topPosition == null) topSquare,
        if ((topLeftPosition != null &&
                topLeftPosition.pieceInfo.color != position.pieceInfo.color) ||
            isEnPassantLeft)
          topLeftSquare,
        if ((topRightPosition != null &&
                topRightPosition.pieceInfo.color != position.pieceInfo.color) ||
            isEnPassantRight)
          topRightSquare,
        if (position.square.rank == Rank.second &&
            topTopPosition == null &&
            topPosition == null)
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
    final isEnPassant = position.square.rank == Rank.fourth &&
        state.move.piece.type == PieceType.pawn;
    final isEnPassantLeft = isEnPassant &&
        state.move.from ==
            getOffsetSquare(
              position.square,
              fileOffset: -1,
              rankOffset: -2,
            ) &&
        state.move.to ==
            getOffsetSquare(
              position.square,
              fileOffset: -1,
            );
    final isEnPassantRight = isEnPassant &&
        state.move.from ==
            getOffsetSquare(
              position.square,
              fileOffset: 1,
              rankOffset: -2,
            ) &&
        state.move.to ==
            getOffsetSquare(
              position.square,
              fileOffset: 1,
            );

    final List<Square> squares = [
      if (topPosition == null) topSquare,
      if ((topLeftPosition != null &&
              topLeftPosition.pieceInfo.color != position.pieceInfo.color) ||
          isEnPassantLeft)
        topLeftSquare,
      if ((topRightPosition != null &&
              topRightPosition.pieceInfo.color != position.pieceInfo.color) ||
          isEnPassantRight)
        topRightSquare,
      if (position.square.rank == Rank.seventh &&
          topTopPosition == null &&
          topPosition == null)
        topTopSquare,
    ];

    return squares;
  }

  if (position.pieceInfo.type == PieceType.king) {
    final whiteKingPosition =
        state.getPiecePosition(const Square(File.e, Rank.first));
    final blackKingPosition =
        state.getPiecePosition(const Square(File.e, Rank.eighth));
    final whiteKingsideRookPosition =
        state.getPiecePosition(const Square(File.h, Rank.first));
    final whiteQueensideRookPosition =
        state.getPiecePosition(const Square(File.a, Rank.first));
    final blackKingsideRookPosition =
        state.getPiecePosition(const Square(File.h, Rank.eighth));
    final blackQueensideRookPosition =
        state.getPiecePosition(const Square(File.a, Rank.eighth));
    final whiteKingNoCheck = !isKingUnderAttack(PieceColor.white, state);
    final blackKingNoCheck = !isKingUnderAttack(PieceColor.black, state);
    final whiteKingNoMove = whiteKingPosition != null && whiteKingPosition.init;
    final blackKingNoMove = blackKingPosition != null && blackKingPosition.init;
    final whiteKingsideRookNoMove =
        whiteKingsideRookPosition != null && whiteKingsideRookPosition.init;
    final whiteQueensideRookNoMove =
        whiteQueensideRookPosition != null && whiteQueensideRookPosition.init;
    final blackKingsideRookNoMove =
        blackKingsideRookPosition != null && blackKingsideRookPosition.init;
    final blackQueensideRookNoMove =
        blackQueensideRookPosition != null && blackQueensideRookPosition.init;
    final whiteKingsideNoPieces = [
      const Square(File.f, Rank.first),
      const Square(File.g, Rank.first)
    ].every((square) => state.getPiecePosition(square) == null);
    final whiteQueensideNoPieces = [
      const Square(File.b, Rank.first),
      const Square(File.c, Rank.first),
      const Square(File.d, Rank.first),
    ].every((square) => state.getPiecePosition(square) == null);
    final blackKingsideNoPieces = [
      const Square(File.f, Rank.eighth),
      const Square(File.g, Rank.eighth)
    ].every((square) => state.getPiecePosition(square) == null);
    final blackQueensideNoPieces = [
      const Square(File.b, Rank.eighth),
      const Square(File.c, Rank.eighth),
      const Square(File.d, Rank.eighth),
    ].every((square) => state.getPiecePosition(square) == null);
    final whiteKingsideNoCheckSquares = [
      const Square(File.f, Rank.first),
      const Square(File.g, Rank.first)
    ].every((square) => !isSquareUnderAttack(PieceColor.white, square, state));
    final whiteQueensideNoCheckSquares = [
      const Square(File.c, Rank.first),
      const Square(File.d, Rank.first),
    ].every((square) => !isSquareUnderAttack(PieceColor.white, square, state));
    final blackKingsideNoCheckSquares = [
      const Square(File.f, Rank.eighth),
      const Square(File.g, Rank.eighth)
    ].every((square) => !isSquareUnderAttack(PieceColor.black, square, state));
    final blackQueensideNoCheckSquares = [
      const Square(File.c, Rank.eighth),
      const Square(File.d, Rank.eighth),
    ].every((square) => !isSquareUnderAttack(PieceColor.black, square, state));

    final whiteKingsideCastle = whiteKingNoCheck &&
        whiteKingNoMove &&
        whiteKingsideRookNoMove &&
        whiteKingsideNoPieces &&
        whiteKingsideNoCheckSquares;
    final whiteQueensideCastle = whiteKingNoCheck &&
        whiteKingNoMove &&
        whiteQueensideRookNoMove &&
        whiteQueensideNoPieces &&
        whiteQueensideNoCheckSquares;
    final blackKingsideCastle = blackKingNoCheck &&
        blackKingNoMove &&
        blackKingsideRookNoMove &&
        blackKingsideNoPieces &&
        blackKingsideNoCheckSquares;
    final blackQueensideCastle = blackKingNoCheck &&
        blackKingNoMove &&
        blackQueensideRookNoMove &&
        blackQueensideNoPieces &&
        blackQueensideNoCheckSquares;

    final List<Square> squares = [
      getOffsetSquare(position.square, rankOffset: 1),
      getOffsetSquare(position.square, fileOffset: 1, rankOffset: 1),
      getOffsetSquare(position.square, fileOffset: 1),
      getOffsetSquare(position.square, fileOffset: 1, rankOffset: -1),
      getOffsetSquare(position.square, rankOffset: -1),
      getOffsetSquare(position.square, fileOffset: -1, rankOffset: -1),
      getOffsetSquare(position.square, fileOffset: -1),
      getOffsetSquare(position.square, fileOffset: -1, rankOffset: 1),
      if (whiteKingsideCastle) const Square(File.g, Rank.first),
      if (whiteQueensideCastle) const Square(File.c, Rank.first),
      if (blackKingsideCastle) const Square(File.g, Rank.eighth),
      if (blackQueensideCastle) const Square(File.c, Rank.eighth),
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

  if (position == null) {
    return [];
  }

  final allSquares = _getPieceMoves(position, state);
  final legalSquares = List<Square>.from(allSquares.where((toSquare) {
    return toSquare != null &&
        (state.getPiecePosition(toSquare) == null ||
            state.getPiecePosition(toSquare).pieceInfo.color !=
                position.pieceInfo.color);
  }).where((toSquare) => !isKingUnderAttack(
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

  for (final Square s in possibleSquares) {
    if (isWhile) {
      final endPosition = state.getPiecePosition(s);

      if (endPosition == null) {
        squares.add(s);
      } else if (startPosition != null &&
          endPosition.pieceInfo.color != startPosition.pieceInfo.color) {
        squares.add(s);
        isWhile = false;
      } else {
        isWhile = false;
      }
    }
  }

  return squares;
}

bool isSquareUnderAttack(PieceColor color, Square square, BoardState state) {
  final List<Square> knightSquares = [
    getOffsetSquare(square, fileOffset: 1, rankOffset: 2),
    getOffsetSquare(square, fileOffset: 2, rankOffset: 1),
    getOffsetSquare(square, fileOffset: 2, rankOffset: -1),
    getOffsetSquare(square, fileOffset: 1, rankOffset: -2),
    getOffsetSquare(square, fileOffset: -1, rankOffset: -2),
    getOffsetSquare(square, fileOffset: -2, rankOffset: -1),
    getOffsetSquare(square, fileOffset: -2, rankOffset: 1),
    getOffsetSquare(square, fileOffset: -1, rankOffset: 2),
  ];

  final isKnightAttack = knightSquares.any((square) {
    final position = state.getPiecePosition(square);

    return position != null &&
        position.pieceInfo.type == PieceType.knight &&
        position.pieceInfo.color != color;
  });

  final List<Square> rookSquares = [
    ...getOffsetSquareSeq(state, square, fileOffset: 1),
    ...getOffsetSquareSeq(state, square, fileOffset: -1),
    ...getOffsetSquareSeq(state, square, rankOffset: -1),
    ...getOffsetSquareSeq(state, square, rankOffset: 1),
  ];

  final isRookQueenAttack = rookSquares.any((square) {
    final position = state.getPiecePosition(square);

    return position != null &&
        [PieceType.rook, PieceType.queen].contains(position.pieceInfo.type) &&
        position.pieceInfo.color != color;
  });

  final List<Square> bishopSquares = [
    ...getOffsetSquareSeq(state, square, fileOffset: 1, rankOffset: 1),
    ...getOffsetSquareSeq(state, square, fileOffset: -1, rankOffset: -1),
    ...getOffsetSquareSeq(state, square, fileOffset: 1, rankOffset: -1),
    ...getOffsetSquareSeq(state, square, fileOffset: -1, rankOffset: 1),
  ];

  final isBishopQueenAttack = bishopSquares.any((square) {
    final position = state.getPiecePosition(square);

    return position != null &&
        [PieceType.bishop, PieceType.queen].contains(position.pieceInfo.type) &&
        position.pieceInfo.color != color;
  });

  final List<Square> pawnSquares = [
    if (color == PieceColor.white)
      getOffsetSquare(square, fileOffset: 1, rankOffset: 1),
    if (color == PieceColor.white)
      getOffsetSquare(square, fileOffset: -1, rankOffset: 1),
    if (color == PieceColor.black)
      getOffsetSquare(square, fileOffset: 1, rankOffset: -1),
    if (color == PieceColor.black)
      getOffsetSquare(square, fileOffset: -1, rankOffset: -1),
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

bool isKingUnderAttack(PieceColor color, BoardState state) {
  final kingPosition = state.piecePositions.firstWhere((position) =>
      position.pieceInfo.type == PieceType.king &&
      position.pieceInfo.color == color);

  return isSquareUnderAttack(color, kingPosition.square, state);
}

bool isColorHasLegalMoves(PieceColor color, BoardState state) {
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
