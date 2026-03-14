import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/game_controller.dart';
import '../../domain/models/player.dart';

class ResultBanner extends ConsumerWidget {
  const ResultBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameControllerProvider);
    final controller = ref.read(gameControllerProvider.notifier);

    if (state.status.isPlaying) return const SizedBox.shrink();

    final String message;
    final Color bgColor;

    if (state.status.isDraw) {
      message = 'It\'s a Draw! 🤝';
      bgColor = Colors.orange;
    } else {
      final winner = state.status.winner!;
      message = winner == Player.black ? 'You Win! 🎉' : 'Computer Wins! 🤖';
      bgColor = winner == Player.black ? Colors.green : Colors.red;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: controller.restart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: bgColor,
            ),
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }
}
