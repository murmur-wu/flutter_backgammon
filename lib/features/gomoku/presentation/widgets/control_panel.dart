import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/game_controller.dart';

class ControlPanel extends ConsumerWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameControllerProvider);
    final controller = ref.read(gameControllerProvider.notifier);

    final canUndo = !state.isAiThinking &&
        state.moveHistory.isNotEmpty &&
        state.status.isPlaying;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: canUndo ? controller.undo : null,
          icon: const Icon(Icons.undo),
          label: const Text('Undo'),
        ),
        ElevatedButton.icon(
          onPressed: controller.restart,
          icon: const Icon(Icons.refresh),
          label: const Text('Restart'),
        ),
      ],
    );
  }
}
