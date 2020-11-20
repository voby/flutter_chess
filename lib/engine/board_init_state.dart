import 'board_state.dart';
import 'enums.dart';
import 'move.dart';
import 'piece_info.dart';
import 'piece_position.dart';
import 'square.dart';

const squareA1 = Square(File.a, Rank.first);
const squareA2 = Square(File.a, Rank.second);
const squareA7 = Square(File.a, Rank.seventh);
const squareA8 = Square(File.a, Rank.eighth);
const squareB1 = Square(File.b, Rank.first);
const squareB2 = Square(File.b, Rank.second);
const squareB7 = Square(File.b, Rank.seventh);
const squareB8 = Square(File.b, Rank.eighth);
const squareC1 = Square(File.c, Rank.first);
const squareC2 = Square(File.c, Rank.second);
const squareC7 = Square(File.c, Rank.seventh);
const squareC8 = Square(File.c, Rank.eighth);
const squareD1 = Square(File.d, Rank.first);
const squareD2 = Square(File.d, Rank.second);
const squareD7 = Square(File.d, Rank.seventh);
const squareD8 = Square(File.d, Rank.eighth);
const squareE1 = Square(File.e, Rank.first);
const squareE2 = Square(File.e, Rank.second);
const squareE7 = Square(File.e, Rank.seventh);
const squareE8 = Square(File.e, Rank.eighth);
const squareF1 = Square(File.f, Rank.first);
const squareF2 = Square(File.f, Rank.second);
const squareF7 = Square(File.f, Rank.seventh);
const squareF8 = Square(File.f, Rank.eighth);
const squareG1 = Square(File.g, Rank.first);
const squareG2 = Square(File.g, Rank.second);
const squareG7 = Square(File.g, Rank.seventh);
const squareG8 = Square(File.g, Rank.eighth);
const squareH1 = Square(File.h, Rank.first);
const squareH2 = Square(File.h, Rank.second);
const squareH7 = Square(File.h, Rank.seventh);
const squareH8 = Square(File.h, Rank.eighth);

const whiteRookA = PieceInfo('white_rook_a', PieceColor.white, PieceType.rook);
const whiteRookH = PieceInfo('white_rook_h', PieceColor.white, PieceType.rook);
const blackRookA = PieceInfo('black_rook_a', PieceColor.black, PieceType.rook);
const blackRookH = PieceInfo('black_rook_h', PieceColor.black, PieceType.rook);
const whiteKnightB =
    PieceInfo('white_knight_b', PieceColor.white, PieceType.knight);
const whiteKnightG =
    PieceInfo('white_knight_g', PieceColor.white, PieceType.knight);
const blackKnightB =
    PieceInfo('black_knight_b', PieceColor.black, PieceType.knight);
const blackKnightG =
    PieceInfo('black_knight_g', PieceColor.black, PieceType.knight);
const whiteBishopC =
    PieceInfo('white_rook_c', PieceColor.white, PieceType.bishop);
const whiteBishopF =
    PieceInfo('white_rook_f', PieceColor.white, PieceType.bishop);
const blackBishopC =
    PieceInfo('black_rook_c', PieceColor.black, PieceType.bishop);
const blackBishopF =
    PieceInfo('black_rook_f', PieceColor.black, PieceType.bishop);
const whiteQueen = PieceInfo('white_queen', PieceColor.white, PieceType.queen);
const blackQueen = PieceInfo('black_queen', PieceColor.black, PieceType.queen);
const whiteKing = PieceInfo('white_king', PieceColor.white, PieceType.king);
const blackKing = PieceInfo('black_king', PieceColor.black, PieceType.king);
const whitePawnA = PieceInfo('white_pawn_a', PieceColor.white, PieceType.pawn);
const whitePawnB = PieceInfo('white_pawn_b', PieceColor.white, PieceType.pawn);
const whitePawnC = PieceInfo('white_pawn_c', PieceColor.white, PieceType.pawn);
const whitePawnD = PieceInfo('white_pawn_d', PieceColor.white, PieceType.pawn);
const whitePawnE = PieceInfo('white_pawn_e', PieceColor.white, PieceType.pawn);
const whitePawnF = PieceInfo('white_pawn_f', PieceColor.white, PieceType.pawn);
const whitePawnG = PieceInfo('white_pawn_g', PieceColor.white, PieceType.pawn);
const whitePawnH = PieceInfo('white_pawn_h', PieceColor.white, PieceType.pawn);
const blackPawnA = PieceInfo('black_pawn_a', PieceColor.black, PieceType.pawn);
const blackPawnB = PieceInfo('black_pawn_b', PieceColor.black, PieceType.pawn);
const blackPawnC = PieceInfo('black_pawn_c', PieceColor.black, PieceType.pawn);
const blackPawnD = PieceInfo('black_pawn_d', PieceColor.black, PieceType.pawn);
const blackPawnE = PieceInfo('black_pawn_e', PieceColor.black, PieceType.pawn);
const blackPawnF = PieceInfo('black_pawn_f', PieceColor.black, PieceType.pawn);
const blackPawnG = PieceInfo('black_pawn_g', PieceColor.black, PieceType.pawn);
const blackPawnH = PieceInfo('black_pawn_h', PieceColor.black, PieceType.pawn);

const initMove = Move(blackKing, squareE8, squareE8);

const initBoardState = BoardState(initMove, [
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
