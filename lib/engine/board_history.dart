import 'board_state.dart';

class BoardHistory {
  final List<BoardState> _boardStates;
  final int _stateIndex;

  const BoardHistory(this._boardStates, {int stateIndex = 0})
      : _stateIndex = stateIndex;

  BoardState get currentState => _boardStates[_stateIndex];

  bool get hasPrevState => _stateIndex > 0;
  BoardHistory setPrevState() {
    if (hasPrevState) {
      return BoardHistory(_boardStates, stateIndex: _stateIndex - 1);
    }

    return this;
  }

  bool get hasNextState => _stateIndex < (_boardStates.length - 1);
  BoardHistory setNextState() {
    if (hasNextState) {
      return BoardHistory(_boardStates, stateIndex: _stateIndex + 1);
    }

    return this;
  }

  BoardHistory addState(BoardState state) {
    if (_stateIndex != (_boardStates.length - 1)) {
      return BoardHistory([..._boardStates.sublist(0, _stateIndex + 1), state],
          stateIndex: _stateIndex + 1);
    }

    return BoardHistory([..._boardStates, state],
        stateIndex: _boardStates.length);
  }

  bool get hasResetState => _boardStates.length > 1;
  BoardHistory resetState() {
    if (hasResetState) {
      return BoardHistory([_boardStates[0]]);
    }

    return this;
  }
}
