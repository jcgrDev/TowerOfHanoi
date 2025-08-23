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

### Detailed Property Analysis

`@Published var disks: [Disk] = []`
 **Type**: Single array containing all disk objects
 **Purpose**: Master collection of all disks in the game

 `@Published var rods: [[Disk]] = [[],[],[]]`
**Type**: 2D Array
**Dimension**: Array of arrays (outer: rods, inner: disk stacks)
**Purpose**: Represents the three rods and which disks are on each rod
<img width="456" height="168" alt="Screenshot 2025-08-23 at 10 02 00 a m" src="https://github.com/user-attachments/assets/4d787a96-6175-45a2-8849-0b5892c3b056" />

`

 `
