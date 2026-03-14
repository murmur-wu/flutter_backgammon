import '../../domain/models/board.dart';

/// Generates candidate move positions near existing stones.
class CandidateGenerator {
  const CandidateGenerator({this.radius = 2});

  final int radius;

  /// Returns a set of (row, col) candidates near placed stones.
  List<(int, int)> generate(Board board) {
    final Set<(int, int)> candidates = {};

    for (int r = 0; r < kBoardSize; r++) {
      for (int c = 0; c < kBoardSize; c++) {
        if (board.getCell(r, c) == null) continue;

        for (int dr = -radius; dr <= radius; dr++) {
          for (int dc = -radius; dc <= radius; dc++) {
            if (dr == 0 && dc == 0) continue;
            final nr = r + dr;
            final nc = c + dc;
            if (board.isValidPosition(nr, nc) && !board.isOccupied(nr, nc)) {
              candidates.add((nr, nc));
            }
          }
        }
      }
    }

    // If board is empty, return center
    if (candidates.isEmpty) {
      candidates.add((kBoardSize ~/ 2, kBoardSize ~/ 2));
    }

    return candidates.toList();
  }
}
