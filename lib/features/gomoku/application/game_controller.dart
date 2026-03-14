import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/ai/heuristic_ai.dart';
import '../domain/models/board.dart';
import '../domain/models/game_status.dart';
import '../domain/models/move.dart';
import '../domain/models/player.dart';
import '../domain/rules/game_rules.dart';
import 'game_state.dart';

final gameControllerProvider =
    NotifierProvider<GameController, GameState>(GameController.new);

class GameController extends Notifier<GameState> {
  final _ai = const HeuristicAI();

  @override
  GameState build() => GameState.initial();

  void placeStone(int row, int col) {
    final s = state;
    if (!s.canAcceptInput) return;
    if (s.board.isOccupied(row, col)) return;
    if (!s.board.isValidPosition(row, col)) return;
    if (s.currentPlayer != Player.black) return;

    final newBoard = s.board.placeStone(row, col, Player.black);
    final newStatus = GameRules.evaluate(newBoard, row, col, Player.black);
    final newHistory = [...s.moveHistory, Move(row: row, col: col, player: Player.black)];

    state = s.copyWith(
      board: newBoard,
      status: newStatus,
      moveHistory: newHistory,
      currentPlayer: Player.white,
      isAiThinking: newStatus.isPlaying,
    );

    if (newStatus.isPlaying) {
      _scheduleAiMove();
    }
  }

  void _scheduleAiMove() {
    final delay = 300 + (DateTime.now().millisecondsSinceEpoch % 500);
    Timer(Duration(milliseconds: delay), _makeAiMove);
  }

  void _makeAiMove() {
    final s = state;
    if (!s.status.isPlaying) return;

    final (row, col) = _ai.chooseMove(s.board);
    final newBoard = s.board.placeStone(row, col, Player.white);
    final newStatus = GameRules.evaluate(newBoard, row, col, Player.white);
    final newHistory = [...s.moveHistory, Move(row: row, col: col, player: Player.white)];

    state = s.copyWith(
      board: newBoard,
      status: newStatus,
      moveHistory: newHistory,
      currentPlayer: Player.black,
      isAiThinking: false,
    );
  }

  void undo() {
    final s = state;
    if (s.isAiThinking) return;
    if (s.moveHistory.isEmpty) return;

    final history = [...s.moveHistory];

    // Remove AI move if last move was AI
    if (history.last.player == Player.white) {
      history.removeLast();
    }

    // Remove player move
    if (history.isNotEmpty && history.last.player == Player.black) {
      history.removeLast();
    }

    // Rebuild board from history
    var newBoard = Board();
    for (final move in history) {
      newBoard = newBoard.placeStone(move.row, move.col, move.player);
    }

    state = GameState(
      board: newBoard,
      currentPlayer: Player.black,
      status: GameStatus.playing,
      moveHistory: history,
      isAiThinking: false,
    );
  }

  void restart() {
    state = GameState.initial();
  }
}
