//
//  HanoiSolver.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 25/08/25.
//

import Foundation

struct HanoiSolver: HanoiGameLogic {
    func generateSolution(for numberOfDisks: Int) -> HanoiSolution {
        var moves: [HanoiMove] = []
        var simulationRods: [[Int]] = [[], [], []]
        
        // Initialize simulation with disks (largest to smallest on rod A)
        for i in stride(from: numberOfDisks, through: 1, by: -1) {
            simulationRods[0].append(i)
        }
        
        solveHanoi(n: numberOfDisks, from: 0, to: 2, auxiliary: 1, rods: &simulationRods, moves: &moves)
        
        return HanoiSolution(numberOfDisks: numberOfDisks, moves: moves)
    }
    
    func isValidMove(from: String, to: String, gameState: GameState) -> Bool {
        let fromIndex = ["A": 0, "B": 1, "C": 2][from] ?? -1
        let toIndex = ["A":0, "B":1, "C":2][to] ?? -1
        
        return gameState.canMoveDisk(from: fromIndex, to: toIndex)
    }
    
    func applyMove(_ move: HanoiMove, to gameState: GameState) -> GameState? {
        return gameState.applyMove(move)
    }
    
    private func solveHanoi(n: Int, from: Int, to: Int, auxiliary: Int, rods: inout [[Int]], moves: inout [HanoiMove]) {
        let rodNames = ["A", "B", "C"]
        
        // Safety check: prevent infinite recursion
        guard n > 0 else {
            return
        }
        
        // Safety check: validate rod indices
        guard from >= 0, from < 3, to >= 0, to < 3, auxiliary >= 0, auxiliary < 3 else {
            return
        }
        
        // Safety check: ensure all rods are different
        guard from != to, from != auxiliary, to != auxiliary else {
            return
        }
        
        // Base case: only one disk to move
        if n == 1 {
            // Safety check: ensure source rod has a disk
            guard !rods[from].isEmpty else {
                return
            }
            
            let disk = rods[from].removeLast()
            rods[to].append(disk)
            moves.append(HanoiMove(from: rodNames[from], to: rodNames[to], disk: disk))
            return
        }
        
        // Recursive case: n > 1
        
        // Phase 1: Move n-1 disks from SOURCE to AUXILIARY (using DESTINATION as temporary space)
        solveHanoi(n: n - 1, from: from, to: auxiliary, auxiliary: to, rods: &rods, moves: &moves)
        
        // Phase 2: Move the largest disk directly from SOURCE to DESTINATION
        guard !rods[from].isEmpty else {
            return
        }
        
        let disk = rods[from].removeLast()
        rods[to].append(disk)
        moves.append(HanoiMove(from: rodNames[from], to: rodNames[to], disk: disk))
        
        // Phase 3: Move n-1 disks from AUXILIARY to DESTINATION (using SOURCE as temporary space)
        solveHanoi(n: n - 1, from: auxiliary, to: to, auxiliary: from, rods: &rods, moves: &moves)
    }
}
