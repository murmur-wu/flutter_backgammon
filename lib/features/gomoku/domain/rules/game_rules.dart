import '../models/board.dart';
import '../models/game_status.dart';
import '../models/player.dart';

const int kWinLength = 5;

class GameRules {
  const GameRules._();

  /// Check if placing at (row, col) causes [player] to win.
  static bool isWinningMove(Board board, int row, int col, Player player) {
    const directions = [
      [0, 1], // horizontal
      [1, 0], // vertical
      [1, 1], // diagonal
      [1, -1], // anti-diagonal
    ];

    for (final dir in directions) {
      final dr = dir[0];
      final dc = dir[1];
      final count = 1 +
          board.countInDirection(row, col, dr, dc, player) +
          board.countInDirection(row, col, -dr, -dc, player);
      if (count >= kWinLength) return true;
    }
    return false;
  }

  /// Evaluate game status after a move at (row, col) by [lastPlayer].
  static GameStatus evaluate(Board board, int row, int col, Player lastPlayer) {
    if (isWinningMove(board, row, col, lastPlayer)) {
      return GameStatus.won(lastPlayer);
    }
    if (board.isFull) return GameStatus.draw;
    return GameStatus.playing;
  }
}
