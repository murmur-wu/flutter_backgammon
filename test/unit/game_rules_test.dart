import 'package:flutter_test/flutter_test.dart';
import 'package:gomoku/features/gomoku/domain/models/board.dart';
import 'package:gomoku/features/gomoku/domain/models/player.dart';
import 'package:gomoku/features/gomoku/domain/models/game_status.dart';
import 'package:gomoku/features/gomoku/domain/rules/game_rules.dart';

void main() {
  group('GameRules', () {
    test('detects horizontal win', () {
      var board = Board();
      for (int c = 0; c < 4; c++) {
        board = board.placeStone(0, c, Player.black);
      }
      board = board.placeStone(0, 4, Player.black);
      expect(GameRules.isWinningMove(board, 0, 4, Player.black), isTrue);
    });

    test('detects vertical win', () {
      var board = Board();
      for (int r = 0; r < 4; r++) {
        board = board.placeStone(r, 0, Player.black);
      }
      board = board.placeStone(4, 0, Player.black);
      expect(GameRules.isWinningMove(board, 4, 0, Player.black), isTrue);
    });

    test('detects diagonal win', () {
      var board = Board();
      for (int i = 0; i < 4; i++) {
        board = board.placeStone(i, i, Player.black);
      }
      board = board.placeStone(4, 4, Player.black);
      expect(GameRules.isWinningMove(board, 4, 4, Player.black), isTrue);
    });

    test('detects anti-diagonal win', () {
      var board = Board();
      for (int i = 0; i < 4; i++) {
        board = board.placeStone(i, 4 - i, Player.black);
      }
      board = board.placeStone(4, 0, Player.black);
      expect(GameRules.isWinningMove(board, 4, 0, Player.black), isTrue);
    });

    test('no win with only 4 in a row', () {
      var board = Board();
      for (int c = 0; c < 4; c++) {
        board = board.placeStone(0, c, Player.black);
      }
      expect(GameRules.isWinningMove(board, 0, 3, Player.black), isFalse);
    });

    test('evaluate returns playing when game not over', () {
      var board = Board();
      board = board.placeStone(0, 0, Player.black);
      final status = GameRules.evaluate(board, 0, 0, Player.black);
      expect(status.isPlaying, isTrue);
    });

    test('evaluate returns won when 5 in a row', () {
      var board = Board();
      for (int c = 0; c < 4; c++) {
        board = board.placeStone(0, c, Player.black);
      }
      board = board.placeStone(0, 4, Player.black);
      final status = GameRules.evaluate(board, 0, 4, Player.black);
      expect(status.isWon, isTrue);
      expect(status.winner, equals(Player.black));
    });
  });
}
