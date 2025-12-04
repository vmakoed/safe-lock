# Safe Lock

A mobile puzzle game collection built with Godot Engine 4.5. Solve a series of mini-game puzzles in sequence to complete the challenge.

**[Play the game here!](https://vmakoed.github.io/safe-lock/)**

## About

Safe Lock is an escape-room style puzzle game featuring four distinct mini-games. Players can select and play puzzles from a level selector menu. The game features a clean, minimalist UI with a monospace programming aesthetic.

## Features

### Puzzle Collection

1. **Safe Code Puzzle** - Crack a 4-digit safe code by rotating digits
2. **Tic-Tac-Toe Puzzle** - Find and select the winning cell in a 3x3 grid
3. **Maze Navigation** - Guide your character through a maze to the exit
4. **Tetrominoes Puzzle** - Place and arrange tetromino pieces on a grid

### Technical Features

- Mobile-first design (1080x1920 vertical orientation)
- On-screen touch controls
- Web export ready (HTML5 via Emscripten)
- Clean signal-based architecture
- Unified UI theme across all puzzles
- Component-based design for reusable elements

## Technology Stack

- **Engine**: Godot 4.5
- **Language**: GDScript
- **Platform**: Mobile (touch-only)
- **Rendering**: Mobile-optimized 2D
- **Font**: Source Code Pro Medium

## Project Structure

```
├── assets/              # Sprites and graphics
├── resources/           # Godot resource files (themes, fonts)
├── scenes/              # Game scenes (.tscn files)
│   ├── game.tscn       # Main game controller
│   ├── level_selector.tscn  # Level selection menu
│   ├── safe.tscn       # Safe code puzzle
│   ├── tic_tac_toe.tscn     # Tic-tac-toe puzzle
│   ├── maze.tscn       # Maze navigation puzzle
│   └── tetrominoes.tscn     # Tetromino placement puzzle
└── scripts/             # GDScript files
    ├── game.gd         # Main game logic
    ├── base_level.gd   # Base class for all puzzles
    └── [puzzle].gd     # Individual puzzle implementations
```

## Getting Started

### Prerequisites

- [Godot Engine 4.5](https://godotengine.org/download) or later

### Running the Game

1. Clone this repository
2. Open the project in Godot Engine
3. Press F5 or click "Run Project" to launch

### Exporting

The game is configured for web export (HTML5). To export:

1. Open Project → Export
2. Select "Web" preset
3. Click "Export Project"

## Controls

Control hints are displayed at the bottom of the screen and change based on the current puzzle context.

## Architecture

The game uses an inheritance-based design with `BaseLevel` as the abstract base class:

```
Control (Godot)
└── BaseLevel
    ├── MessageScreen (intro/outro)
    ├── LevelSelector
    ├── Safe
    ├── TicTacToe
    ├── Maze
    └── Tetrominoes
```

The game flow is managed by [game.gd](scripts/game.gd), which handles scene transitions and winning conditions.

## Development

### Adding a New Puzzle

1. Create a new scene inheriting from [base_level.tscn](scenes/base_level.tscn)
2. Create a corresponding script extending `BaseLevel`
3. Implement the puzzle logic
4. Add the puzzle to [level_selector.tscn](scenes/level_selector.tscn)

### Key Classes

- [game.gd](scripts/game.gd) - Main game controller, manages scene transitions
- [base_level.gd](scripts/base_level.gd) - Abstract base class for all levels
- [level_selector.gd](scripts/level_selector.gd) - Level selection menu
- Individual puzzle scripts in [scripts/](scripts/)

## License

This project is available for educational and personal use.

## Credits

Developed using Godot Engine 4.5
