//
//  GameState.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 25/08/25.
//

import Foundation

struct GameState: Equatable {
    let rods: [[Int]]
    let numberOfDisks: Int
    let currentStep: Int
    let isCompleted: Bool
    
    init(numberOfDisks: Int, currentStep: Int) {
        self.numberOfDisks = numberOfDisks
        self.currentStep = currentStep
        
        // Initialize with all disks on rod A (largest to smallest)
        var rodA: [Int] = []
        for i in stride(from: numberOfDisks, through: 1, by: -1) {
            rodA.append(i)
        }
        
        self.rods = [rodA, [], []]
        self.isCompleted = false
    }
    
    init(rods: [[Int]], numberOfDisks: Int, currentStep: Int = 0) {
        self.rods = rods
        self.numberOfDisks = numberOfDisks
        self.currentStep = currentStep
        self.isCompleted = rods[2].count == numberOfDisks
    }
    
    // Test helper methods
    func isValidState() -> Bool {
        let totalDisks = rods.flatMap { $0 }.count
        guard totalDisks == numberOfDisks else {
            return false
        }
        
        // Check each rod for valid stacking (larger disks below smaller ones)
        for rod in rods {
            // Skip rods with 0 or 1 disk - They're always valid
            guard rod.count > 1 else { continue }
            
            for i in 0..<rod.count - 1 {
                if rod[i] <= rod[i + 1] {
                    return false
                }
            }
        }
        
        return true
    }
    
    func canMoveDisk(from: Int, to: Int) -> Bool {
        guard from != to,   // Different rods
              from >= 0, from < rods.count, // Valid indices
              to >= 0, to < rods.count else {
            return false
        }
        
        let diskToMove = rods[from].last!
        
        if rods[to].isEmpty {
            return true // Can always move to empty rod
        }
        
        let topDiskAtDestination = rods[to].last!
        
        return diskToMove < topDiskAtDestination // Smaller on larger only
    }
    
    func applyMove(_ move: HanoiMove) -> GameState? {
        let fromIndex = ["A": 0, "B": 1, "C": 2][move.from] ?? -1
        let toIndex = ["A": 0, "B": 1, "C": 2][move.to] ?? -1
        
        guard canMoveDisk(from: fromIndex, to: toIndex) else {
            return nil
        }
        
        var newRods = rods
        let disk = newRods[fromIndex].removeLast()
        newRods[toIndex].append(disk)
        
        return GameState(rods: newRods, numberOfDisks: numberOfDisks, currentStep: currentStep + 1)
    }
}
