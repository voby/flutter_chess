import 'package:flutter/material.dart';

import 'board_controls.dart';
import 'engine/board_history.dart';
import 'engine/board_init_state.dart';
import 'engine/enums.dart';
import 'engine/move_validation.dart';
import 'engine/piece_info.dart';
import 'engine/piece_position.dart';
import 'engine/square.dart';
import 'piece.dart';

class Board extends StatefulWidget {
  const Board({
    Key key,
  }) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  BoardHistory boardHistory;
  Square fromSquare;
  List<Square> legalMoves = [];
  PieceColor focusSide = PieceColor.white;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenWidth,
            child: Row(
              children: buildFiles,
            ),
          ),
          BoardControls(
            rotateBoard: rotateBoard,
            hasRestartGame: boardHistory.hasResetState,
            restartGame: restartGame,
            hasNextState: boardHistory.hasNextState,
            setNextState: setNextState,
            hasPrevState: boardHistory.hasPrevState,
            setPrevState: setPrevState,
          ),
        ],
      ),
    );
  }

  List<Widget> get buildFiles {
    final seed = focusSide == PieceColor.white
        ? List.generate(8, (i) => i)
        : List.generate(8, (i) => i).reversed;

    return seed.map((fileIndex) {
      return Flexible(
        child: Column(
          children: buildSquares(fileIndex),
        ),
      );
    }).toList();
  }

  List<Widget> buildSquares(int fileIndex) {
    final seed = focusSide == PieceColor.white
        ? List.generate(8, (i) => i).reversed
        : List.generate(8, (i) => i);

    return seed.map((rankIndex) {
      final square = Square.fromIndexes(fileIndex, rankIndex);
      final squareColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown : Colors.brown[100];
      final PiecePosition piecePosition =
          boardHistory.currentState.getPiecePosition(square);

      final isLegalMoveSquare = legalMoves.contains(square);

      final isKing = piecePosition != null &&
          piecePosition.pieceInfo.type == PieceType.king &&
          piecePosition.pieceInfo.color ==
              boardHistory.currentState.movingColor;
      final isCheck = isKing &&
          isSquareUnderAttack(
              piecePosition.pieceInfo.color, square, boardHistory.currentState);
      final isStalemate = isKing && boardHistory.currentState.isStalemate();
      final isCheckmate = isKing && boardHistory.currentState.isCheckmate();

      final child = piecePosition != null
          ? Piece(
              pieceInfo: piecePosition.pieceInfo,
              containerColor: isCheckmate
                  ? Colors.redAccent.withOpacity(0.8)
                  : isStalemate
                      ? Colors.yellowAccent.withOpacity(0.8)
                      : fromSquare == square
                          ? Colors.greenAccent.withOpacity(0.3)
                          : isLegalMoveSquare
                              ? Colors.redAccent.withOpacity(0.3)
                              : null,
            )
          : isLegalMoveSquare
              ? SizedBox.expand(
                  child: Container(color: Colors.greenAccent.withOpacity(0.3)))
              : const SizedBox.expand();
      final color = squareColor;
      final border = Border.all(
        color: piecePosition != null && isLegalMoveSquare
            ? Colors.redAccent.withOpacity(0.7)
            : square == fromSquare || isLegalMoveSquare
                ? Colors.greenAccent.withOpacity(0.7)
                : isCheck
                    ? Colors.redAccent
                    : isStalemate
                        ? Colors.yellowAccent.withOpacity(.7)
                        : Colors.transparent,
        width: 2,
      );

      return Flexible(
        child: GestureDetector(
          onTap: onSquareTap(square, piecePosition),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              border: border,
            ),
            child: child,
          ),
        ),
      );
    }).toList();
  }

  void cancelMove() {
    setState(() {
      fromSquare = null;
      legalMoves = [];
    });
  }

  void completeMove(Square toSquare) {
    final fromPosition = boardHistory.currentState.getPiecePosition(fromSquare);
    final isPromotion = fromPosition.pieceInfo.type == PieceType.pawn &&
        [Rank.first, Rank.eighth].contains(toSquare.rank);

    if (isPromotion) {
      print('Promotion');
      showModalBottomSheet<Widget>(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PieceType.queen,
                  PieceType.knight,
                  PieceType.bishop,
                  PieceType.rook
                ]
                    .map(
                      (pieceType) => InkWell(
                        onTap: () {
                          _completeMove(toSquare, pieceType);
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Piece(
                            pieceInfo: PieceInfo(
                              'id',
                              fromPosition.pieceInfo.color,
                              pieceType,
                            ),
                            // Colors.green,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          });
    } else {
      _completeMove(toSquare);
    }
  }

  void _completeMove(Square toSquare, [PieceType promotionPiece]) {
    final newState = boardHistory.currentState
        .addMove(fromSquare, toSquare, promotionPiece: promotionPiece);

    setState(() {
      boardHistory = boardHistory.addState(newState);
      fromSquare = null;
      legalMoves = [];
    });
  }

  void initMove(Square square) {
    setState(() {
      fromSquare = square;
      legalMoves = getValidMoves(square, boardHistory.currentState);
    });
  }

  @override
  void initState() {
    super.initState();
    boardHistory = const BoardHistory([initBoardState]);
  }

  VoidCallback onSquareTap(Square square, PiecePosition piecePosition) {
    return () {
      if (piecePosition != null &&
          piecePosition.pieceInfo.color ==
              boardHistory.currentState.movingColor) {
        if (fromSquare != square) {
          initMove(square);
        } else {
          cancelMove();
        }
      } else if (legalMoves.contains(square)) {
        completeMove(square);
      }
    };
  }

  void restartGame() {
    if (boardHistory.hasResetState) {
      setState(() {
        fromSquare = null;
        legalMoves = [];
        boardHistory = boardHistory.resetState();
      });
    }
  }

  void rotateBoard() {
    setState(() {
      focusSide =
          focusSide == PieceColor.white ? PieceColor.black : PieceColor.white;
    });
  }

  void setPrevState() {
    if (boardHistory.hasPrevState) {
      setState(() {
        fromSquare = null;
        legalMoves = [];
        boardHistory = boardHistory.setPrevState();
      });
    }
  }

  void setNextState() {
    if (boardHistory.hasNextState) {
      fromSquare = null;
      legalMoves = [];
      setState(() {
        boardHistory = boardHistory.setNextState();
      });
    }
  }
}
