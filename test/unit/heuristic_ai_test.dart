import 'package:flutter_test/flutter_test.dart';
import 'package:gomoku/features/gomoku/domain/models/board.dart';
import 'package:gomoku/features/gomoku/domain/models/player.dart';
import 'package:gomoku/features/gomoku/data/ai/heuristic_ai.dart';
import 'package:gomoku/features/gomoku/data/ai/candidate_generator.dart';

void main() {
  group('CandidateGenerator', () {
    test('returns center when board is empty', () {
      const gen = CandidateGenerator();
      final board = Board();
      final candidates = gen.generate(board);
      expect(candidates, contains((kBoardSize ~/ 2, kBoardSize ~/ 2)));
    });

    test('returns positions near placed stones', () {
      const gen = CandidateGenerator(radius: 1);
      var board = Board();
      board = board.placeStone(7, 7, Player.black);
      final candidates = gen.generate(board);
      expect(candidates, contains((6, 7)));
      expect(candidates, contains((7, 6)));
      expect(candidates, contains((8, 8)));
    });
  });

  group('HeuristicAI', () {
    test('takes winning move immediately', () {
      const ai = HeuristicAI();
      var board = Board();
      // 4 white stones in a row
      for (int c = 0; c < 4; c++) {
        board = board.placeStone(7, c, Player.white);
      }
      final (row, col) = ai.chooseMove(board);
      // AI should complete the 5 in a row
      expect(row, equals(7));
      expect(col, equals(4));
    });

    test('blocks player from winning', () {
      const ai = HeuristicAI();
      var board = Board();
      // 4 black stones in a row
      for (int c = 0; c < 4; c++) {
        board = board.placeStone(7, c, Player.black);
      }
      // One white stone elsewhere
      board = board.placeStone(0, 0, Player.white);
      final (row, col) = ai.chooseMove(board);
      // AI should block at (7, 4)
      expect(row, equals(7));
      expect(col, equals(4));
    });

    test('returns valid move for empty-ish board', () {
      const ai = HeuristicAI();
      var board = Board();
      board = board.placeStone(7, 7, Player.black);
      final (row, col) = ai.chooseMove(board);
      expect(board.isValidPosition(row, col), isTrue);
      expect(board.isOccupied(row, col), isFalse);
    });
  });
}
