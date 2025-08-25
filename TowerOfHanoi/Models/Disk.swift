//
//  Disk.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 22/08/25.
//

import Foundation

class Disk: ObservableObject, Identifiable {
    let id = UUID()
    var size: Int
    @Published var position: CGPoint = .zero
    @Published var rod: Int = 0
    
    init(size: Int, rod: Int = 0) {
        self.size = size
        self.rod = rod
    }
}
