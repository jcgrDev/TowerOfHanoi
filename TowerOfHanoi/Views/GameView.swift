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
                
                // Disks
                ForEach(game.disks) { disk in
                    DiskView(
                        disk: disk,
                        game: game,
                        geometry: geometry,
                        isDragged: draggedDisk?.id == disk.id,
                        dragOffset: dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if draggedDisk == nil && game.rods[disk.rod].last?.id == disk.id {
                                    draggedDisk = disk
                                }
                                if draggedDisk?.id == disk.id {
                                    dragOffset = value.translation
                                }
                            }
                            .onEnded { value in
                                if let draggedDisk = draggedDisk, draggedDisk.id == disk.id {
                                    handleDrop(disk: draggedDisk, location: value.location, geometry: geometry)
                                }
                                
                                self.draggedDisk = nil
                                dragOffset = .zero
                            }
                    )
                }
                
                if game.gameCompleted {
                    VStack {
                        Text("🎉 Congratulations! 🎉")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        Text("Puzzle Solved!")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
        }
    }
    
    private func handleDrop(disk: Disk, location: CGPoint, geometry: GeometryProxy) {
        let rodWidth = geometry.size.width / 3
        let targetRod = min(2, max(0, Int(location.x / rodWidth)))
        
        withAnimation(.easeInOut(duration: 0.3)) {
            _ = game.moveDisk(from: disk.rod, to: targetRod)
        }
    }
}
