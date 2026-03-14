import 'player.dart';

enum GameStatusType { playing, won, draw }

class GameStatus {
  const GameStatus._({
    required this.type,
    this.winner,
  });

  final GameStatusType type;
  final Player? winner;

  static const GameStatus playing = GameStatus._(type: GameStatusType.playing);
  static const GameStatus draw = GameStatus._(type: GameStatusType.draw);

  factory GameStatus.won(Player winner) =>
      GameStatus._(type: GameStatusType.won, winner: winner);

  bool get isPlaying => type == GameStatusType.playing;
  bool get isOver => type != GameStatusType.playing;
  bool get isDraw => type == GameStatusType.draw;
  bool get isWon => type == GameStatusType.won;

  @override
  String toString() {
    if (isWon) return 'GameStatus.won(${winner!.name})';
    if (isDraw) return 'GameStatus.draw';
    return 'GameStatus.playing';
  }
}
