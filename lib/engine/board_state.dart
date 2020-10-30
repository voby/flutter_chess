import 'package:equatable/equatable.dart';

import 'enums.dart';
import 'move.dart';
import 'move_validation.dart';
import 'piece_info.dart';
import 'piece_position.dart';
import 'square.dart';

class BoardState extends Equatable {
  final Move _move;
  final List<PiecePosition> _piecePositions;

  BoardState(this._move, this._piecePositions);

  @override
  List<Object> get props => [_move, _piecePositions];

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

  BoardState addMove(Square fromSquare, Square toSquare,
      {promotionPiece = PieceType.queen}) {
    final fromPosition = getPiecePosition(fromSquare);
    final toPosition = getPiecePosition(toSquare);
    final move = Move(fromPosition.pieceInfo, fromSquare, toSquare);

    final piecePositions = List<PiecePosition>.from(_piecePositions)
      ..removeWhere((position) => position == fromPosition)
      ..removeWhere((position) => position == toPosition)
      ..add(PiecePosition(toSquare, fromPosition.pieceInfo));

    // promotion
    if (fromPosition.pieceInfo.type == PieceType.pawn &&
        [Rank.first, Rank.eighth].contains(toSquare.rank)) {
      final newPiece = PieceInfo(
          'promoted_' + fromPosition.pieceInfo.id, movingColor, promotionPiece);
      piecePositions
        ..removeWhere((position) => position.square == toSquare)
        ..add(PiecePosition(toSquare, newPiece));
    }

    // castle
    final rank = fromPosition.pieceInfo.color == PieceColor.white
        ? Rank.first
        : Rank.eighth;
    if (fromPosition.pieceInfo.type == PieceType.king &&
        fromPosition.square == Square(File.e, rank)) {
      if (toSquare == Square(File.g, rank)) {
        final rookPosition = piecePositions
            .where((position) => position.square == Square(File.h, rank))
            .first;
        piecePositions
          ..removeWhere((position) => position == rookPosition)
          ..add(PiecePosition(Square(File.f, rank), rookPosition.pieceInfo));
      } else if (toSquare == Square(File.c, rank)) {
        final rookPosition = piecePositions
            .where((position) => position.square == Square(File.a, rank))
            .first;
        piecePositions
          ..removeWhere((position) => position == rookPosition)
          ..add(PiecePosition(Square(File.d, rank), rookPosition.pieceInfo));
      }
    }

    return BoardState(move, piecePositions);
  }

  List<Square> getLegalMoves(Square fromSquare) {
    return getValidMoves(fromSquare, this);
  }

  bool isStalemate() {
    return isColorHasLegalMoves(movingColor, this);
  }

  bool isCheckmate() {
    return isKingUnderAttack(movingColor, this) &&
        isColorHasLegalMoves(movingColor, this);
  }
}
