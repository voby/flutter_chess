import 'package:equatable/equatable.dart';

import 'piece_info.dart';
import 'square.dart';

class PiecePosition extends Equatable {
  final Square square;
  final PieceInfo pieceInfo;
  final bool init;

  PiecePosition(this.square, this.pieceInfo, {this.init = false});

  @override
  List<Object> get props => [square, pieceInfo, init];
}
