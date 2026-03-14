import '../../domain/models/board.dart';
import '../../domain/models/player.dart';
import '../../domain/rules/game_rules.dart';
import 'candidate_generator.dart';

/// Heuristic-based Gomoku AI playing as [Player.white].
class HeuristicAI {
  const HeuristicAI({CandidateGenerator? generator})
      : _generator = generator ?? const CandidateGenerator();

  final CandidateGenerator _generator;

  /// Returns the best move (row, col) for [Player.white].
  (int, int) chooseMove(Board board) {
    final candidates = _generator.generate(board);

    (int, int)? bestMove;
    int bestScore = -1 << 30;

    for (final candidate in candidates) {
      final (row, col) = candidate;

      // Priority 1: Win immediately
      if (GameRules.isWinningMove(board, row, col, Player.white)) {
        return candidate;
      }

      // Priority 2: Block player from winning
      if (GameRules.isWinningMove(board, row, col, Player.black)) {
        bestMove = candidate;
        bestScore = 1 << 29;
        continue;
      }

      // Heuristic score
      final score = _scorePosition(board, row, col);
      if (score > bestScore) {
        bestScore = score;
        bestMove = candidate;
      }
    }

    return bestMove ?? candidates.first;
  }

  int _scorePosition(Board board, int row, int col) {
    int score = 0;
    score += _evaluateFor(board, row, col, Player.white) * 2;
    score += _evaluateFor(board, row, col, Player.black);
    return score;
  }

  int _evaluateFor(Board board, int row, int col, Player player) {
    const directions = [
      [0, 1],
      [1, 0],
      [1, 1],
      [1, -1],
    ];
    int totalScore = 0;
    for (final dir in directions) {
      final dr = dir[0];
      final dc = dir[1];
      final forward = board.countInDirection(row, col, dr, dc, player);
      final backward = board.countInDirection(row, col, -dr, -dc, player);
      final consecutive = forward + backward + 1;

      // Open ends
      final frontOpen = _isOpen(board, row, col, dr, dc, forward + 1);
      final backOpen = _isOpen(board, row, col, -dr, -dc, backward + 1);
      final openEnds = (frontOpen ? 1 : 0) + (backOpen ? 1 : 0);

      totalScore += _patternScore(consecutive, openEnds);
    }
    return totalScore;
  }

  bool _isOpen(Board board, int row, int col, int dr, int dc, int steps) {
    final r = row + dr * steps;
    final c = col + dc * steps;
    if (!board.isValidPosition(r, c)) return false;
    return board.getCell(r, c) == null;
  }

  int _patternScore(int consecutive, int openEnds) {
    if (openEnds == 0) {
      return switch (consecutive) {
        >= 5 => 100000,
        4 => 100,
        3 => 10,
        _ => 1,
      };
    } else if (openEnds == 1) {
      return switch (consecutive) {
        >= 5 => 100000,
        4 => 10000,
        3 => 500,
        2 => 50,
        _ => 5,
      };
    } else {
      // openEnds == 2
      return switch (consecutive) {
        >= 5 => 100000,
        4 => 50000,
        3 => 5000,
        2 => 500,
        _ => 10,
      };
    }
  }
}
