import 'package:flutter/material.dart';
import '../../domain/models/board.dart';
import '../../domain/models/player.dart';

class BoardPainter extends CustomPainter {
  const BoardPainter({required this.board, this.lastMove});

  final Board board;
  final (int, int)? lastMove;

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / kBoardSize;
    _drawBackground(canvas, size);
    _drawGrid(canvas, size, cellSize);
    _drawStarPoints(canvas, cellSize);
    _drawStones(canvas, cellSize);
  }

  void _drawBackground(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFDEB887);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _drawGrid(Canvas canvas, Size size, double cellSize) {
    final paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 0.8;

    for (int i = 0; i < kBoardSize; i++) {
      final offset = (i + 0.5) * cellSize;
      canvas.drawLine(
        Offset(offset, cellSize * 0.5),
        Offset(offset, size.height - cellSize * 0.5),
        paint,
      );
      canvas.drawLine(
        Offset(cellSize * 0.5, offset),
        Offset(size.width - cellSize * 0.5, offset),
        paint,
      );
    }
  }

  void _drawStarPoints(Canvas canvas, double cellSize) {
    final paint = Paint()..color = Colors.black87;
    const starPoints = [3, 7, 11];
    for (final r in starPoints) {
      for (final c in starPoints) {
        canvas.drawCircle(
          Offset((c + 0.5) * cellSize, (r + 0.5) * cellSize),
          3.5,
          paint,
        );
      }
    }
  }

  void _drawStones(Canvas canvas, double cellSize) {
    final stoneRadius = cellSize * 0.44;

    for (int r = 0; r < kBoardSize; r++) {
      for (int c = 0; c < kBoardSize; c++) {
        final player = board.getCell(r, c);
        if (player == null) continue;

        final center = Offset((c + 0.5) * cellSize, (r + 0.5) * cellSize);
        final isLast =
            lastMove != null && lastMove!.$1 == r && lastMove!.$2 == c;

        _drawStone(canvas, center, stoneRadius, player, isLast);
      }
    }
  }

  void _drawStone(
    Canvas canvas,
    Offset center,
    double radius,
    Player player,
    bool isLast,
  ) {
    final isBlack = player == Player.black;

    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(center + const Offset(1.5, 1.5), radius, shadowPaint);

    // Stone fill
    final gradient = RadialGradient(
      center: const Alignment(-0.3, -0.3),
      radius: 0.7,
      colors: isBlack
          ? [Colors.grey.shade600, Colors.black]
          : [Colors.white, Colors.grey.shade300],
    );
    final rect = Rect.fromCircle(center: center, radius: radius);
    final stonePaint = Paint()..shader = gradient.createShader(rect);
    canvas.drawCircle(center, radius, stonePaint);

    // Last move marker
    if (isLast) {
      final markerPaint = Paint()
        ..color = isBlack ? Colors.white : Colors.red
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius * 0.25, markerPaint);
    }
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) =>
      oldDelegate.board != board || oldDelegate.lastMove != lastMove;
}
