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
    let source: SolutionSource
    
    enum SolutionSource: String, Codable {
        case local = "local"
        case remote = "cloud_generated"
    }
    
    init(numberOfDisks: Int, moves: [HanoiMove], source: SolutionSource = .local) {
        self.numberOfDisks = numberOfDisks
        self.moves = moves
        self.totalMoves = moves.count
        self.source = source
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.numberOfDisks = try container.decode(Int.self, forKey: .numberOfDisks)
        self.moves = try container.decode([HanoiMove].self, forKey: .moves)
        self.totalMoves = try container.decode(Int.self, forKey: .totalMoves)
        self.source = try container.decode(HanoiSolution.SolutionSource.self, forKey: .source)
    }
    
    private enum CodingKeys: String, CodingKey {
        case numberOfDisks
        case moves
        case totalMoves
        case source
    }
}
