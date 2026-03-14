import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/game_controller.dart';
import '../../domain/models/player.dart';

class StatusBar extends ConsumerWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameControllerProvider);
    final theme = Theme.of(context);

    String text;
    Color color;

    if (state.status.isWon) {
      final winner = state.status.winner!;
      text = winner == Player.black ? 'You win! 🎉' : 'Computer wins!';
      color = winner == Player.black ? Colors.green : Colors.red;
    } else if (state.status.isDraw) {
      text = 'Draw! 🤝';
      color = Colors.orange;
    } else if (state.isAiThinking) {
      text = 'Computer is thinking...';
      color = theme.colorScheme.secondary;
    } else {
      text = 'Your turn (Black)';
      color = theme.colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.isAiThinking)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ),
          Text(
            text,
            style: theme.textTheme.headlineMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
