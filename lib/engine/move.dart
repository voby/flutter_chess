import 'package:equatable/equatable.dart';

import 'piece_info.dart';
import 'square.dart';

class Move extends Equatable {
  final PieceInfo piece;
  final Square from;
  final Square to;

  const Move(this.piece, this.from, this.to);

  @override
  List<Object> get props => [piece, from, to];
}
