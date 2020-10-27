import 'board_state.dart';
import 'enums.dart';
import 'move.dart';
import 'piece_info.dart';
import 'piece_position.dart';
import 'square.dart';

final squareA1 = Square(File.a, Rank.first);
final squareA2 = Square(File.a, Rank.second);
final squareA7 = Square(File.a, Rank.seventh);
final squareA8 = Square(File.a, Rank.eighth);
final squareB1 = Square(File.b, Rank.first);
final squareB2 = Square(File.b, Rank.second);
final squareB7 = Square(File.b, Rank.seventh);
final squareB8 = Square(File.b, Rank.eighth);
final squareC1 = Square(File.c, Rank.first);
final squareC2 = Square(File.c, Rank.second);
final squareC7 = Square(File.c, Rank.seventh);
final squareC8 = Square(File.c, Rank.eighth);
final squareD1 = Square(File.d, Rank.first);
final squareD2 = Square(File.d, Rank.second);
final squareD7 = Square(File.d, Rank.seventh);
final squareD8 = Square(File.d, Rank.eighth);
final squareE1 = Square(File.e, Rank.first);
final squareE2 = Square(File.e, Rank.second);
final squareE7 = Square(File.e, Rank.seventh);
final squareE8 = Square(File.e, Rank.eighth);
final squareF1 = Square(File.f, Rank.first);
final squareF2 = Square(File.f, Rank.second);
final squareF7 = Square(File.f, Rank.seventh);
final squareF8 = Square(File.f, Rank.eighth);
final squareG1 = Square(File.g, Rank.first);
final squareG2 = Square(File.g, Rank.second);
final squareG7 = Square(File.g, Rank.seventh);
final squareG8 = Square(File.g, Rank.eighth);
final squareH1 = Square(File.h, Rank.first);
final squareH2 = Square(File.h, Rank.second);
final squareH7 = Square(File.h, Rank.seventh);
final squareH8 = Square(File.h, Rank.eighth);

final whiteRookA = PieceInfo('white_rook_a', PieceColor.white, PieceType.rook);
final whiteRookH = PieceInfo('white_rook_h', PieceColor.white, PieceType.rook);
final blackRookA = PieceInfo('black_rook_a', PieceColor.black, PieceType.rook);
final blackRookH = PieceInfo('black_rook_h', PieceColor.black, PieceType.rook);
final whiteKnightB =
    PieceInfo('white_knight_b', PieceColor.white, PieceType.knight);
final whiteKnightG =
    PieceInfo('white_knight_g', PieceColor.white, PieceType.knight);
final blackKnightB =
    PieceInfo('black_knight_b', PieceColor.black, PieceType.knight);
final blackKnightG =
    PieceInfo('black_knight_g', PieceColor.black, PieceType.knight);
final whiteBishopC =
    PieceInfo('white_rook_c', PieceColor.white, PieceType.bishop);
final whiteBishopF =
    PieceInfo('white_rook_f', PieceColor.white, PieceType.bishop);
final blackBishopC =
    PieceInfo('black_rook_c', PieceColor.black, PieceType.bishop);
final blackBishopF =
    PieceInfo('black_rook_f', PieceColor.black, PieceType.bishop);
final whiteQueen = PieceInfo('white_queen', PieceColor.white, PieceType.queen);
final blackQueen = PieceInfo('black_queen', PieceColor.black, PieceType.queen);
final whiteKing = PieceInfo('white_king', PieceColor.white, PieceType.king);
final blackKing = PieceInfo('black_king', PieceColor.black, PieceType.king);
final whitePawnA = PieceInfo('white_pawn_a', PieceColor.white, PieceType.pawn);
final whitePawnB = PieceInfo('white_pawn_b', PieceColor.white, PieceType.pawn);
final whitePawnC = PieceInfo('white_pawn_c', PieceColor.white, PieceType.pawn);
final whitePawnD = PieceInfo('white_pawn_d', PieceColor.white, PieceType.pawn);
final whitePawnE = PieceInfo('white_pawn_e', PieceColor.white, PieceType.pawn);
final whitePawnF = PieceInfo('white_pawn_f', PieceColor.white, PieceType.pawn);
final whitePawnG = PieceInfo('white_pawn_g', PieceColor.white, PieceType.pawn);
final whitePawnH = PieceInfo('white_pawn_h', PieceColor.white, PieceType.pawn);
final blackPawnA = PieceInfo('black_pawn_a', PieceColor.black, PieceType.pawn);
final blackPawnB = PieceInfo('black_pawn_b', PieceColor.black, PieceType.pawn);
final blackPawnC = PieceInfo('black_pawn_c', PieceColor.black, PieceType.pawn);
final blackPawnD = PieceInfo('black_pawn_d', PieceColor.black, PieceType.pawn);
final blackPawnE = PieceInfo('black_pawn_e', PieceColor.black, PieceType.pawn);
final blackPawnF = PieceInfo('black_pawn_f', PieceColor.black, PieceType.pawn);
final blackPawnG = PieceInfo('black_pawn_g', PieceColor.black, PieceType.pawn);
final blackPawnH = PieceInfo('black_pawn_h', PieceColor.black, PieceType.pawn);

final initMove = Move(blackKing, squareE8, squareE8);

final initBoardState = BoardState(initMove, [
  PiecePosition(squareA1, whiteRookA, init: true),
  PiecePosition(squareH1, whiteRookH, init: true),
  PiecePosition(squareA8, blackRookA, init: true),
  PiecePosition(squareH8, blackRookH, init: true),
  PiecePosition(squareB1, whiteKnightB, init: true),
  PiecePosition(squareG1, whiteKnightG, init: true),
  PiecePosition(squareB8, blackKnightB, init: true),
  PiecePosition(squareG8, blackKnightG, init: true),
  PiecePosition(squareC1, whiteBishopC, init: true),
  PiecePosition(squareF1, whiteBishopF, init: true),
  PiecePosition(squareC8, blackBishopC, init: true),
  PiecePosition(squareF8, blackBishopF, init: true),
  PiecePosition(squareD1, whiteQueen, init: true),
  PiecePosition(squareD8, blackQueen, init: true),
  PiecePosition(squareE1, whiteKing, init: true),
  PiecePosition(squareE8, blackKing, init: true),
  PiecePosition(squareA2, whitePawnA, init: true),
  PiecePosition(squareB2, whitePawnB, init: true),
  PiecePosition(squareC2, whitePawnC, init: true),
  PiecePosition(squareD2, whitePawnD, init: true),
  PiecePosition(squareE2, whitePawnE, init: true),
  PiecePosition(squareF2, whitePawnF, init: true),
  PiecePosition(squareG2, whitePawnG, init: true),
  PiecePosition(squareH2, whitePawnH, init: true),
  PiecePosition(squareA7, blackPawnA, init: true),
  PiecePosition(squareB7, blackPawnB, init: true),
  PiecePosition(squareC7, blackPawnC, init: true),
  PiecePosition(squareD7, blackPawnD, init: true),
  PiecePosition(squareE7, blackPawnE, init: true),
  PiecePosition(squareF7, blackPawnF, init: true),
  PiecePosition(squareG7, blackPawnG, init: true),
  PiecePosition(squareH7, blackPawnH, init: true),
]);
