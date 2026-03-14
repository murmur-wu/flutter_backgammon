import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gomoku/features/gomoku/presentation/screens/game_screen.dart';
import 'package:gomoku/features/gomoku/presentation/screens/home_screen.dart';

void main() {
  testWidgets('GameScreen shows board and controls', (tester) async {
    final router = GoRouter(
      initialLocation: '/game',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/game', builder: (_, __) => const GameScreen()),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Restart'), findsOneWidget);
    expect(find.text('Undo'), findsOneWidget);
    expect(find.text('Your turn (Black)'), findsOneWidget);
  });

  testWidgets('Restart button resets the game', (tester) async {
    final router = GoRouter(
      initialLocation: '/game',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/game', builder: (_, __) => const GameScreen()),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restart'));
    await tester.pumpAndSettle();

    expect(find.text('Your turn (Black)'), findsOneWidget);
  });
}
