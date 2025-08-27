//
//  DiskView.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 26/08/25.
//

import SwiftUI

struct DiskView: View {
    @ObservedObject var disk: Disk
    @ObservedObject var game: HanoiGame
    let geometry: GeometryProxy
    let isDragged: Bool
    let dragOffset: CGSize
    
    var body: some View {
        let rodWidth = geometry.size.width / 3
        let baseX = rodWidth * (CGFloat(disk.rod) + 0.5)
        let stackPosition = CGFloat(game.rods[disk.rod].firstIndex(where: { $0.id == disk.id}) ?? 0)
        let baseY = geometry.size.height - 40 - (stackPosition * 25)
        
        Rectangle()
            .fill(diskColor)
            .frame(width: diskWidth, height: 20)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
            .position(
                x: isDragged ? baseX + dragOffset.width : baseX,
                y: isDragged ? baseY + dragOffset.height: baseY
            )
            .scaleEffect(isDragged ? 1.1 : 1.0)
            .shadow(radius: isDragged ? 8 : 2)
            .zIndex(isDragged ? 1000 : Double(10 - disk.size))
        
    }
    
    private var diskWidth: CGFloat {
        let baseWidth: CGFloat = 60
        let widthIncrement: CGFloat = 25
        return baseWidth + (CGFloat(disk.size - 1) * widthIncrement)
    }
    
    private var diskColor: Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .gray]
        return colors[(disk.size - 1) % colors.count]
    }
}
