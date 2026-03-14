import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Text(
                'GOMOKU',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Five in a Row',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              const Spacer(flex: 2),
              const _RulesCard(),
              const Spacer(flex: 3),
              ElevatedButton(
                onPressed: () => context.go('/game'),
                child: const Text('Start Game'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _RulesCard extends StatelessWidget {
  const _RulesCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How to Play', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            const _RuleItem(icon: Icons.circle, color: Colors.black, text: 'You play Black stones'),
            const _RuleItem(icon: Icons.circle, color: Colors.white70, text: 'Computer plays White stones'),
            const _RuleItem(icon: Icons.grid_on, text: 'Tap any empty intersection to place'),
            const _RuleItem(icon: Icons.emoji_events, text: 'First to get 5 in a row wins'),
            const _RuleItem(icon: Icons.swap_horiz, text: 'Horizontal, vertical & diagonal all count'),
          ],
        ),
      ),
    );
  }
}

class _RuleItem extends StatelessWidget {
  const _RuleItem({required this.text, this.icon, this.color});

  final String text;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, size: 16, color: color ?? Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
