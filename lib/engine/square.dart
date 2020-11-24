import 'package:equatable/equatable.dart';

import 'enums.dart';

class Square extends Equatable {
  final File file;
  final Rank rank;

  const Square(this.file, this.rank);

  factory Square.fromIndexes(int fileIndex, int rankIndex) {
    return Square(File.values[fileIndex], Rank.values[rankIndex]);
  }

  int get fileIndex => File.values.indexOf(file);
  int get rankIndex => Rank.values.indexOf(rank);

  @override
  List<Object> get props => [file, rank];

  @override
  bool get stringify => true;
}
