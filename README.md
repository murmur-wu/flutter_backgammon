# Gomoku — Five in a Row

A production-ready Flutter mobile application for the classic Gomoku (Five-in-a-row) board game.

## Supported Platforms

- ✅ iOS
- ✅ Android
- ❌ Web (not supported)
- ❌ Desktop (not supported)

## Architecture Overview

This project follows a clean architecture approach:

```
lib/
├── app/                    # App entry (routing, MaterialApp)
├── core/
│   └── theme/              # App theme
└── features/
    └── gomoku/
        ├── domain/         # Models, rules, pure game logic
        ├── application/    # Riverpod providers, game controller
        ├── data/           # AI implementation
        └── presentation/   # Screens, widgets, painters
```

### Layer Responsibilities

| Layer | Responsibility |
|-------|---------------|
| `domain` | Board model, Player, Move, GameStatus, GameRules |
| `application` | GameController (Riverpod Notifier), GameState |
| `data` | HeuristicAI, CandidateGenerator |
| `presentation` | HomeScreen, GameScreen, GomokuBoard, StatusBar, etc. |

## Game Rules

- 15×15 board
- Player: Black stones (goes first)
- Computer: White stones
- First to get 5 in a row (horizontal, vertical, or diagonal) wins
- If the board fills up with no winner, it's a draw

## AI Design

The computer AI uses a heuristic evaluation approach:

1. **Win immediately** — if a 5-in-a-row is available, take it
2. **Block opponent** — if the player is about to win, block it
3. **Score positions** — evaluate patterns (open threes, fours, etc.)

## Installation

```bash
# Clone the repository
git clone https://github.com/murmur-wu/flutter_backgammon.git
cd flutter_backgammon

# Install dependencies
flutter pub get
```

## Running

### iOS Simulator

```bash
open -a Simulator
flutter run -d ios
```

### Android Emulator/Device

```bash
flutter run -d android
```

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Versioning and Release

This project uses [Semantic Versioning](https://semver.org/): `vMAJOR.MINOR.PATCH`

## Future Extensions

- Minimax with alpha-beta pruning for stronger AI
- Multiple difficulty levels (easy / medium / hard)
- Game history persistence
- Score tracking across sessions
- Animations for stone placement
- Sound effects
- Dark mode support
