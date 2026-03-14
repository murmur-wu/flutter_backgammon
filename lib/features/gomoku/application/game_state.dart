import '../domain/models/board.dart';
import '../domain/models/game_status.dart';
import '../domain/models/move.dart';
import '../domain/models/player.dart';

class GameState {
  const GameState({
    required this.board,
    required this.currentPlayer,
    required this.status,
    required this.moveHistory,
    required this.isAiThinking,
  });

  final Board board;
  final Player currentPlayer;
  final GameStatus status;
  final List<Move> moveHistory;
  final bool isAiThinking;

  static GameState initial() => GameState(
        board: Board(),
        currentPlayer: Player.black,
        status: GameStatus.playing,
        moveHistory: const [],
        isAiThinking: false,
      );

  bool get canAcceptInput => !isAiThinking && status.isPlaying;

  GameState copyWith({
    Board? board,
    Player? currentPlayer,
    GameStatus? status,
    List<Move>? moveHistory,
    bool? isAiThinking,
  }) {
    return GameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      status: status ?? this.status,
      moveHistory: moveHistory ?? this.moveHistory,
      isAiThinking: isAiThinking ?? this.isAiThinking,
    );
  }
}
