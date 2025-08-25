//
//  HanoiGame.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 22/08/25.
//

import Foundation

class HanoiGame: ObservableObject {
    @Published var disks: [Disk] = []
    @Published var rods: [[Disk]] = [[],[],[]]
    @Published var numberOfDisks: Int = 3
    @Published var currentStep: Int = 0
    @Published var solution: HanoiSolution?
    @Published var gameCompleted: Bool = false
    
    private let rodNames = ["A", "B", "C"]
    private let solver: HanoiGameLogic
    
    init(solver: HanoiGameLogic = HanoiSolver()) {
        self.solver = solver
        setupGame()
        generateSolution()
    }
    
    init(numberOfDisks: Int, solver: HanoiGameLogic = HanoiSolver()) {
        self.numberOfDisks = numberOfDisks
        self.solver = solver
        setupGame()
        generateSolution()
    }
    
    func setupGame() {
        disks.removeAll()
        rods = [[], [], []]
        currentStep = 0
        gameCompleted = false
        
        for i in stride(from: numberOfDisks, to: 1, by: -1) {
            let disk = Disk(size: i, rod: 0)
            disks.append(disk)
            rods[0].append(disk)
        }
    }
    
    func generateSolution() {
        solution = solver.generateSolution(for: numberOfDisks)
    }
}
