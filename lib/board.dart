import 'package:flutter/material.dart';

import 'board_controls.dart';
import 'engine/board_history.dart';
import 'engine/board_init_state.dart';
import 'engine/enums.dart';
import 'engine/move_validation.dart';
import 'engine/piece_info.dart';
import 'engine/square.dart';
import 'piece.dart';

class Room extends StatefulWidget {
  const Room({
    Key key,
  }) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
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
          Stack(
            children: [
              BoardLayer(screenWidth: screenWidth, buildFiles: buildFiles),
              SizedBox(
                width: screenWidth,
                height: screenWidth,
                child: Stack(
                  children: [
                    ...boardHistory.currentState.getLegalMoves(fromSquare).map(
                      (square) {
                        final left = focusSide == PieceColor.white
                            ? screenWidth * square.fileIndex / 8
                            : null;
                        final bottom = focusSide == PieceColor.white
                            ? screenWidth * square.rankIndex / 8
                            : null;
                        final right = focusSide != PieceColor.white
                            ? screenWidth * square.fileIndex / 8
                            : null;
                        final top = focusSide != PieceColor.white
                            ? screenWidth * square.rankIndex / 8
                            : null;

                        return Positioned(
                          left: left,
                          bottom: bottom,
                          right: right,
                          top: top,
                          child: GestureDetector(
                            onTap: onSquareTap(square),
                            child: Container(
                              width: screenWidth / 8,
                              height: screenWidth / 8,
                              color: Colors.greenAccent.withOpacity(0.3),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth,
                height: screenWidth,
                child: Stack(
                  children: [
                    ...boardHistory.currentState.piecePositions
                        .map((piecePosition) {
                      final isLegalMoveSquare =
                          legalMoves.contains(piecePosition.square);

                      final isKing = piecePosition != null &&
                          piecePosition.pieceInfo.type == PieceType.king &&
                          piecePosition.pieceInfo.color ==
                              boardHistory.currentState.movingColor;
                      final isCheck = isKing &&
                          isSquareUnderAttack(piecePosition.pieceInfo.color,
                              piecePosition.square, boardHistory.currentState);
                      final isStalemate =
                          isKing && boardHistory.currentState.isStalemate();
                      final isCheckmate =
                          isKing && boardHistory.currentState.isCheckmate();

                      final border = Border.all(
                        color: piecePosition != null && isLegalMoveSquare
                            ? Colors.redAccent.withOpacity(0.7)
                            : piecePosition.square == fromSquare ||
                                    isLegalMoveSquare
                                ? Colors.greenAccent.withOpacity(0.7)
                                : isCheck
                                    ? Colors.redAccent
                                    : isStalemate
                                        ? Colors.yellowAccent.withOpacity(.7)
                                        : Colors.transparent,
                        width: 2,
                      );

                      final left = focusSide == PieceColor.white
                          ? screenWidth * piecePosition.square.fileIndex / 8
                          : screenWidth -
                              (screenWidth *
                                  (piecePosition.square.fileIndex + 1) /
                                  8);
                      final bottom = focusSide == PieceColor.white
                          ? screenWidth * piecePosition.square.rankIndex / 8
                          : screenWidth -
                              (screenWidth *
                                  (piecePosition.square.rankIndex + 1) /
                                  8);

                      return AnimatedPositioned(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(milliseconds: 500),
                        left: left,
                        bottom: bottom,
                        key: Key(
                            piecePosition.pieceInfo.id + focusSide.toString()),
                        child: GestureDetector(
                          onTap: onSquareTap(piecePosition.square),
                          child: Container(
                            width: screenWidth / 8,
                            height: screenWidth / 8,
                            decoration: BoxDecoration(
                              color: isCheckmate
                                  ? Colors.redAccent.withOpacity(0.8)
                                  : isStalemate
                                      ? Colors.yellowAccent.withOpacity(0.8)
                                      : fromSquare == piecePosition.square
                                          ? Colors.greenAccent.withOpacity(0.3)
                                          : isLegalMoveSquare
                                              ? Colors.redAccent
                                                  .withOpacity(0.3)
                                              : null,
                              border: border,
                            ),
                            child: Piece(
                              pieceInfo: piecePosition.pieceInfo,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
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
      final size = MediaQuery.of(context).size.width / 8;
      final squareColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown : Colors.brown[100];
      final numberColor =
          fileIndex % 2 == rankIndex % 2 ? Colors.brown[100] : Colors.brown;

      return Container(
        color: squareColor,
        width: size,
        height: size,
        child: Stack(
          children: [
            if (focusSide == PieceColor.white ? fileIndex == 7 : fileIndex == 0)
              Positioned(
                top: 1,
                right: 1,
                child: Text(
                  (rankIndex + 1).toString(),
                  style: TextStyle(
                    color: numberColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (focusSide == PieceColor.white ? rankIndex == 0 : rankIndex == 7)
              Positioned(
                bottom: 1,
                left: 1,
                child: Text(
                  File.values[fileIndex].toString().split('.').last,
                  style: TextStyle(
                    color: numberColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
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

  VoidCallback onSquareTap(Square square) {
    return () {
      final piecePosition = boardHistory.currentState.getPiecePosition(square);

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

class BoardLayer extends StatelessWidget {
  const BoardLayer({
    Key key,
    @required this.screenWidth,
    @required this.buildFiles,
  }) : super(key: key);

  final double screenWidth;
  final List<Widget> buildFiles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: screenWidth,
      child: Row(
        children: buildFiles,
      ),
    );
  }
}
