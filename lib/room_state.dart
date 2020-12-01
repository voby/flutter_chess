import 'engine/board_history.dart';
import 'engine/enums.dart';
import 'engine/square.dart';

class RoomState {
  BoardHistory boardHistory;
  Square fromSquare;
  List<Square> legalMoves;
  PieceColor focusSide = PieceColor.white;

  RoomState({
    this.boardHistory,
    this.fromSquare,
    this.legalMoves = const [],
    this.focusSide = PieceColor.white,
  });

  RoomState copyWith({
    BoardHistory boardHistory,
    Nullable<Square> fromSquare,
    List<Square> legalMoves,
    PieceColor focusSide,
  }) =>
      RoomState(
        boardHistory: boardHistory ?? this.boardHistory,
        fromSquare: fromSquare == null ? this.fromSquare : fromSquare.value,
        legalMoves: legalMoves ?? this.legalMoves,
        focusSide: focusSide ?? this.focusSide,
      );
}

class Nullable<T> {
  final T _value;

  Nullable(this._value);

  T get value {
    return _value;
  }
}
