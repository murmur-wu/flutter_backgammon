import 'player.dart';

class Move {
  const Move({required this.row, required this.col, required this.player});

  final int row;
  final int col;
  final Player player;

  @override
  bool operator ==(Object other) =>
      other is Move &&
      other.row == row &&
      other.col == col &&
      other.player == player;

  @override
  int get hashCode => Object.hash(row, col, player);

  @override
  String toString() => 'Move(row: $row, col: $col, player: $player)';
}
