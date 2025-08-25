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
}
