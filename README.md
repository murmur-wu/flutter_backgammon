# Gomoku — Five in a Row

A production-ready Flutter mobile application for the classic Gomoku (Five-in-a-row) board game.

## Supported Platforms

- ✅ iOS (iOS 13+ · fully compatible with iOS 26)
- ✅ Android
- ❌ Web (not supported)
- ❌ Desktop (not supported)

### iOS 26 Compatibility

This project targets the latest Flutter stable channel (≥ 3.38), which is required for iOS 26 / Xcode 26 compatibility and App Store submission from April 2026 onward. The minimum iOS deployment target is **iOS 13**.

> From April 28, 2026, Apple requires all App Store submissions to be built with Xcode 26 and the iOS 26 SDK. Flutter 3.38+ provides full support for this requirement.

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

## Prerequisites

- **Flutter** latest stable (≥ 3.38 for iOS 26 / Xcode 26 support) — [install Flutter](https://docs.flutter.dev/get-started/install)
- **Xcode 26+** (for iOS 26 builds)
- **Android Studio** or any IDE with Flutter plugin

## Installation

```bash
# Clone the repository
git clone https://github.com/murmur-wu/flutter_backgammon.git
cd flutter_backgammon

# Install dependencies
flutter pub get
```

## Running

### iOS Simulator (including iOS 26)

```bash
# Install pod dependencies first
cd ios && pod install && cd ..ç

# Run on iOS simulator
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
