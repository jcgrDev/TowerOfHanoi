# Tower of Hanoi - Class Diagram

## Table of Contents
- [Class Diagram](#class-diagram)
- [Class Descriptions](#class-descriptions)
  - [Data Models](#data-models)
  - [Game Logic](#game-logic)
- [Algorithm Implementation](#algorithm-implementation)

## Class Diagram

## Class Descriptions

### Data Models

#### `HanoiMove`
- **Purpose**: Represents a single move in the Tower of Hanoi puzzle
- **Properties**: 
  - `from`: Source rod identifier
  - `to`: Destination rod identifier  
  - `disk`: Size of the disk being moved
- **Conforms to**: `Codable`, `Identifiable`

#### `Disk`
- **Purpose**: Represents an individual disk in the game
- **Properties**:
  - `size`: Relative size of the disk (1 = smallest)
  - `position`: Current visual position (CGPoint)
  - `rod`: Current rod index (0, 1, or 2)
- **Conforms to**: `ObservableObject`, `Identifiable`
- 
#### `HanoiSolution`
- **Purpose**: Contains the complete solution for a given number of disks
- **Properties**:
  - `numberOfDisks`: Number of disks in the puzzle
  - `moves`: Array of all moves required to solve
  - `totalMoves`: Total number of moves needed
- **Conforms to**: `Codable`

### Game Logic

#### `HanoiGame`
- **Purpose**: Main game controller managing all game state and logic
- **Key Properties**:
  - `disks`: Array of all disk objects
  - `rods`: 2D array representing the three rods
  - `solution`: Generated solution for current configuration
- **Key Methods**:
  - `setupGame()`: Initialize game state
  - `generateSolution()`: Create optimal solution
  - `moveDisk()`: Execute disk movement with validation
  - `autoSolve()`: Animate the complete solution
- **Conforms to**: `ObservableObject`

#### `GameState`
- **Purpose**: Immutable representation of game state for logic validation and testing.

### `Why This Design`
- **Immutable**: Creates new state for each move, preventing accidental mutations.
- **Pure Data**: Uses integers instead of UI objects for clean logic.
- **Testable**: Easy to create specific game states for unit testing.


## Algorithm Implementation

**Base Case (n = 1)**
`swift
if n == 1 {
    guard !rods[from].isEmpty else { return }
    
    let disk = rods[from].removeLast()
    rods[to].append(disk)
    moves.append(HanoiMove(from: rodNames[from], to: rodNames[to], disk: disk))
    return
}
`

### Recursive Case Phase 1: Clear the Path
`
swift
solveHanoi(n: n - 1, from: from, to: auxiliary, auxiliary: to, 
           rods: &rods, moves: &moves)
`

**Purpose**: Move the n-1 smaller disks out of the way so the largest disk can move


### Recursive Case Phase 2: Move the Obstacle
`
swift
    guard !rods[from].isEmpty else { return }
    let disk = rods[from].removeLast()
    rods[to].append(disk)
moves.append(HanoiMove(from: rodNames[from], to: rodNames[to], disk: disk))
`

**Purpose**: Move the largest disk to its final destination.

### Recursive Case Phase 3: Complete the Tower
`swift
solveHanoi(n: n - 1, from: auxiliary, to: to, auxiliary: from, 
           rods: &rods, moves: &moves)
`

**Purpose**: Move the n-1 disks from auxiliary rod to destination (on top of the largest disk)