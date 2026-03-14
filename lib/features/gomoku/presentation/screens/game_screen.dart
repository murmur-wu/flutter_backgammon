import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/gomoku_board.dart';
import '../widgets/status_bar.dart';
import '../widgets/control_panel.dart';
import '../widgets/result_banner.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gomoku'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const StatusBar(),
              const SizedBox(height: 12),
              const GomokuBoard(),
              const SizedBox(height: 12),
              const ResultBanner(),
              const Spacer(),
              const ControlPanel(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
