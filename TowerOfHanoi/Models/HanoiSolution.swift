//
//  HanoiSolution.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 22/08/25.
//

import Foundation

struct HanoiSolution: Codable {
    let numberOfDisks: Int
    let moves: [HanoiMove]
    let totalMoves: Int
    
    init(numberOfDisks: Int, moves: [HanoiMove]) {
        self.numberOfDisks = numberOfDisks
        self.moves = moves
        self.totalMoves = moves.count
    }
}
