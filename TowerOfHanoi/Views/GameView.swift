//
//  GameView.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 25/08/25.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: HanoiGame
    @State private var draggedDisk: Disk?
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.brown.opacity(0.3)
                    .ignoresSafeArea()
                
                // Base Platform
                Rectangle()
                    .fill(Color.brown)
                    .frame(height: 20)
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 10)
                
                // Rods
                ForEach(0..<3) { rodIndex in
                    RodView(rodIndex: rodIndex, geometry: geometry)
                }
            }
        }
    }
}
