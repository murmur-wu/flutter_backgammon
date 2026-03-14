enum Player {
  black,
  white;

  Player get opponent => this == Player.black ? Player.white : Player.black;

  @override
  String toString() => name;
}
