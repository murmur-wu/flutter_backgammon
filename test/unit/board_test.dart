import 'package:flutter_test/flutter_test.dart';
import 'package:gomoku/features/gomoku/domain/models/board.dart';
import 'package:gomoku/features/gomoku/domain/models/player.dart';

void main() {
  group('Board', () {
    test('initial board is empty', () {
      final board = Board();
      for (int r = 0; r < kBoardSize; r++) {
        for (int c = 0; c < kBoardSize; c++) {
          expect(board.getCell(r, c), isNull);
          expect(board.isOccupied(r, c), isFalse);
        }
      }
    });

    test('placeStone returns new board with stone', () {
      final board = Board();
      final newBoard = board.placeStone(7, 7, Player.black);
      expect(newBoard.getCell(7, 7), equals(Player.black));
      expect(board.getCell(7, 7), isNull); // original unchanged
    });

    test('isValidPosition returns false for out of bounds', () {
      final board = Board();
      expect(board.isValidPosition(-1, 0), isFalse);
      expect(board.isValidPosition(0, kBoardSize), isFalse);
      expect(board.isValidPosition(kBoardSize, 0), isFalse);
    });

    test('isFull returns false when board has empty cells', () {
      final board = Board();
      expect(board.isFull, isFalse);
    });

    test('countInDirection counts consecutive stones', () {
      var board = Board();
      for (int c = 1; c <= 3; c++) {
        board = board.placeStone(0, c, Player.black);
      }
      // From (0, 0) direction right
      final count = board.countInDirection(0, 0, 0, 1, Player.black);
      expect(count, equals(3));
    });
  });
}
