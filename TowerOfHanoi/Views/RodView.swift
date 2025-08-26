//
//  RodView.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 26/08/25.
//

import SwiftUI

struct RodView: View {
    let rodIndex: Int
    let geometry: GeometryProxy
    
    var body: some View {
        let rodWidth = geometry.size.width / 3
        let rodx = rodWidth * (CGFloat(rodIndex) + 0.5)
        
        VStack {
            // Rod
            Rectangle()
                .fill(Color.brown)
                .frame(width: 8, height: geometry.size.height * 0.8)
                .position(x: rodx, y: geometry.size.height * 0.5)
            Text(["A", "B", "C"][rodIndex])
                .font(.title2)
                .fontWeight(.bold)
                .position(x: rodx, y: geometry.size.height - 40)
        }
    }
}
