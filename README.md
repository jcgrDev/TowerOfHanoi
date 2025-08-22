# Tower of Hanoi - Class Diagram

## Table of Contents
- [Class Diagram](#class-diagram)
- [Class Descriptions](#class-descriptions)
  - [Data Models](#data-models)
  - [Game Logic](#game-logic)

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
