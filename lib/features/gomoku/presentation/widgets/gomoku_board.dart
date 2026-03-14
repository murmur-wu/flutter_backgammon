import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/game_controller.dart';
import '../../domain/models/board.dart';
import '../painters/board_painter.dart';

class GomokuBoard extends ConsumerWidget {
  const GomokuBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final controller = ref.read(gameControllerProvider.notifier);

    (int, int)? lastMove;
    if (gameState.moveHistory.isNotEmpty) {
      final last = gameState.moveHistory.last;
      lastMove = (last.row, last.col);
    }

    return AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        onTapUp: gameState.canAcceptInput
            ? (details) => _onTap(details, context, controller)
            : null,
        child: CustomPaint(
          painter: BoardPainter(board: gameState.board, lastMove: lastMove),
        ),
      ),
    );
  }

  void _onTap(TapUpDetails details, BuildContext context, GameController controller) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final localPos = box.globalToLocal(details.globalPosition);
    final cellSize = box.size.width / kBoardSize;

    final col = (localPos.dx / cellSize).floor();
    final row = (localPos.dy / cellSize).floor();

    controller.placeStone(row, col);
  }
}
