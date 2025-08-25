//
//  HanoiSolverTests.swift
//  TowerOfHanoiTests
//
//  Created by Juan Carlos Guzman Rosales on 25/08/25.
//

import Testing
@testable import TowerOfHanoi

struct HanoiSolverTests {
    
    @Test func testOneDiskSolution() async throws {
        let solver = HanoiSolver()
        let solution = solver.generateSolution(for: 1)
        
        #expect(solution.numberOfDisks == 1)
        #expect(solution.totalMoves == 1)
        
        let move = try #require(solution.moves.first)
        #expect(move.from == "A")
        #expect(move.to == "C")
        #expect(move.disk == 1)
        #expect(move.description == "Move disk 1 from rod A to rod C")
    }
    
    @Test("Solver generate correct solution for 2 disks")
    func testTwoDisksSolution() async throws {
        let solver = HanoiSolver()
        let solution = solver.generateSolution(for: 2)
        
        #expect(solution.numberOfDisks == 2)
        #expect(solution.totalMoves == 3)
        
        #expect(solution.moves[0].from == "A")
        #expect(solution.moves[0].to == "B")
        #expect(solution.moves[0].disk == 1)
        
        #expect(solution.moves[1].from == "A")
        #expect(solution.moves[1].to == "C")
        #expect(solution.moves[1].disk == 2)
        
        #expect(solution.moves[2].from == "B")
        #expect(solution.moves[2].to == "C")
        #expect(solution.moves[2].disk == 1)
    }
    
    @Test("Solver generates correct solution for 3 disks")
    func testThreeDiskSolution() async throws {
        let solver = HanoiSolver()
        let solution = solver.generateSolution(for: 3)
        
        #expect(solution.numberOfDisks == 3)
        #expect(solution.totalMoves == 7) // 2^3 - 1 = 7
        
        // Verify complete sequence for 3 disks
        let expectedMoves = [
            ("A", "C", 1), ("A", "B", 2), ("C", "B", 1),
            ("A", "C", 3), ("B", "A", 1), ("B", "C", 2),
            ("A", "C", 1)
        ]
        
        #expect(solution.moves.count == expectedMoves.count)
        
        for (index, expectedMove) in expectedMoves.enumerated() {
            let actualMove = solution.moves[index]
            #expect(actualMove.from == expectedMove.0, "Move \(index + 1) from rod incorrect")
            #expect(actualMove.to == expectedMove.1, "Move \(index + 1) to rod incorrect")
            #expect(actualMove.disk == expectedMove.2, "Move \(index + 1) disk incorrect")
        }
    }
}
