import 'package:equatable/equatable.dart';

import 'enums.dart';

class PieceInfo extends Equatable {
  final String id;
  final PieceColor color;
  final PieceType type;

  const PieceInfo(this.id, this.color, this.type);

  @override
  List<Object> get props => [id];
}
