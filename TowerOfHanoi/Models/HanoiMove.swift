//
//  HanoiMove.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 22/08/25.
//

import Foundation

struct HanoiMove: Codable, Identifiable {
    let id = UUID()
    let from: String
    let to: String
    let disk: Int
    let description: String
    
    init(from: String, to: String, disk: Int) {
        self.from = from
        self.to = to
        self.disk = disk
        self.description = "Move disk \(disk) from rod \(from) to rod\(to)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case from, to, disk, description
    }
}
