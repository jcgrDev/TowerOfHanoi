//
//  ContentView.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 22/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = HanoiGame()
    var body: some View {
        GeometryReader { geometry in
            HStack {
                GameView(game: game)
                    .frame(width: geometry.size.width * 0.7)
            }
        }
    }
}

#Preview {
    ContentView()
}
