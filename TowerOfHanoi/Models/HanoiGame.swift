//
//  HanoiGame.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 22/08/25.
//

import Foundation
import SwiftUI

class HanoiGame: ObservableObject {
    @Published var disks: [Disk] = []
    @Published var rods: [[Disk]] = [[],[],[]]
    @Published var numberOfDisks: Int = 3
    @Published var currentStep: Int = 0
    @Published var solution: HanoiSolution?
    @Published var gameCompleted: Bool = false
    @Published var isAnimating: Bool = false
    @Published var showingSolution: Bool = false
    @Published var cloudService =  FirebaseHanoiService()
    @Published var isLoadingCloudSolution = false
    @Published var preferCloudSolution: Bool = false
    
    private let rodNames = ["A", "B", "C"]
    private let solver: HanoiGameLogic
    
    init(solver: HanoiGameLogic = HanoiSolver()) {
        self.solver = solver
        setupGame()
        Task {
            await generateSolution()
        }
    }
    
    init(numberOfDisks: Int, solver: HanoiGameLogic = HanoiSolver()) {
        self.numberOfDisks = numberOfDisks
        self.solver = solver
        setupGame()
        Task {
            await generateSolution()
        }
    }
    
    func setupGame() {
        disks.removeAll()
        rods = [[], [], []]
        currentStep = 0
        gameCompleted = false
        
        for i in stride(from: numberOfDisks, through: 1, by: -1) {
            let disk = Disk(size: i, rod: 0)
            disks.append(disk)
            rods[0].append(disk)
        }
    }
    
    @MainActor
    func generateSolution(preferCloud: Bool = false) async {
        if preferCloudSolution {
            if !cloudService.hasBeenTested {
                await cloudService.testConnection()
            }
            
            if cloudService.isConnectd {
                await generateCloudSolution()
            } else {
                print("⚠️ Cloud preferred but not connected, using local solution")
                generateLocalSolution()
            }
        } else {
            generateLocalSolution()
        }
    }
    
    @MainActor
    func generateCloudSolution() async {
        isLoadingCloudSolution = true
        
        do {
            let response = try await cloudService.getSolution(numberOfDisks: numberOfDisks)
            solution = response.solution
            
            print("Solution loaded from cloud")
        } catch {
            print("❌ Cloud solution failed: \(error)")
            generateLocalSolution() // Fallback to local
        }
        
        isLoadingCloudSolution = false
    }
    
    @MainActor
    func refreshSolution() async {
        await generateSolution()
    }
    
    func canMoveDisk(from fromRod: Int, to toRod: Int) -> Bool {
        guard !rods[fromRod].isEmpty else { return false }
        guard fromRod != toRod else { return false }
        
        let topDisk = rods[fromRod].last!
        
        if rods[toRod].isEmpty {
            return true
        }
        
        let destinationTopDisk = rods[toRod].last!
        return topDisk.size < destinationTopDisk.size
    }
    
    func moveDisk(from fromRod: Int, to toRod: Int) -> Bool {
        guard canMoveDisk(from: fromRod, to: toRod) else { return false }
        
        let disk = rods[fromRod].removeLast()
        disk.rod = toRod
        rods[toRod].append(disk)
        
        checkGameCompletion()
        return true
    }
    
    private func checkGameCompletion(){
        gameCompleted = rods[2].count == numberOfDisks
    }
    
    private func generateLocalSolution() {
        solution = solver.generateSolution(for: numberOfDisks)
    }
    
    func resetGame() {
        setupGame()
        Task {
            await generateSolution()
        }
    }
    
    func updateNumberOfDisks(_ count: Int) {
        numberOfDisks = max(1, min(8, count))
        resetGame()
    }
    
    
    // AutoSolve
    func autoSolve() {
        guard !isAnimating else { return } // AutoSolve in progress
        
        if solution == nil {
            Task {
                await generateSolution()
                executeAutoSolve()
            }
        } else {
            executeNextMove()
        }
    }
    
    private func executeAutoSolve() {
        isAnimating = true
        currentStep = 0
        executeNextMove()
    }
    
    private func executeNextMove() {
        guard let solution = solution, currentStep < solution.moves.count else {
            isAnimating = false
            return
        }
        
        let move = solution.moves[currentStep]
        let fromRod = rodNames.firstIndex(of: move.from)!
        let toRod = rodNames.firstIndex(of: move.to)!
        
        withAnimation(.easeInOut(duration: 0.8)) {
            _ = moveDisk(from: fromRod, to: toRod)
        }
        
        currentStep += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.executeNextMove()
        }
    }
}
