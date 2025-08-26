//
//  HanoiGameLogic.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 25/08/25.
//

import Foundation

protocol HanoiGameLogic {
    func generateSolution(for numberOfDisks: Int) -> HanoiSolution
    func isValidMove(from: String, to: String, gameState: GameState) -> Bool
    func applyMove(_ move: HanoiMove, to gameState: GameState) -> GameState?
}
