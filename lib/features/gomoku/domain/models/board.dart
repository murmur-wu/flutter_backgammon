import 'player.dart';

const int kBoardSize = 15;

class Board {
  Board()
      : _cells =
            List.generate(kBoardSize, (_) => List.filled(kBoardSize, null));

  Board._fromCells(List<List<Player?>> cells) : _cells = cells;

  final List<List<Player?>> _cells;

  Player? getCell(int row, int col) => _cells[row][col];

  bool isOccupied(int row, int col) => _cells[row][col] != null;

  bool isValidPosition(int row, int col) =>
      row >= 0 && row < kBoardSize && col >= 0 && col < kBoardSize;

  bool get isFull {
    for (int r = 0; r < kBoardSize; r++) {
      for (int c = 0; c < kBoardSize; c++) {
        if (_cells[r][c] == null) return false;
      }
    }
    return true;
  }

  /// Returns a new Board with the stone placed.
  Board placeStone(int row, int col, Player player) {
    assert(!isOccupied(row, col));
    final newCells = List.generate(
      kBoardSize,
      (r) => List<Player?>.from(_cells[r]),
    );
    newCells[row][col] = player;
    return Board._fromCells(newCells);
  }

  /// Count consecutive stones in a direction from (row, col).
  int countInDirection(int row, int col, int dr, int dc, Player player) {
    int count = 0;
    int r = row + dr;
    int c = col + dc;
    while (isValidPosition(r, c) && _cells[r][c] == player) {
      count++;
      r += dr;
      c += dc;
    }
    return count;
  }

  List<List<Player?>> get cells => _cells;
}
