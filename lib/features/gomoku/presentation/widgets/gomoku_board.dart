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
      child: LayoutBuilder(
        builder: (_, constraints) {
          final cellSize = constraints.maxWidth / kBoardSize;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: gameState.canAcceptInput
                ? (details) {
                    final col = (details.localPosition.dx / cellSize).floor();
                    final row = (details.localPosition.dy / cellSize).floor();
                    controller.placeStone(row, col);
                  }
                : null,
            child: CustomPaint(
              painter: BoardPainter(board: gameState.board, lastMove: lastMove),
              child: const SizedBox.expand(),
            ),
          );
        },
      ),
    );
  }
}
