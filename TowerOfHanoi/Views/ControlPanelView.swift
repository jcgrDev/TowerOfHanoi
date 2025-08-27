//
//  ControlPanelView.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 26/08/25.
//

import SwiftUI

struct ControlPanelView: View {
    @ObservedObject var game: HanoiGame
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tower of Hanoi")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            // Number of disks selector
            VStack {
                Text("Number of Disks: \(game.numberOfDisks)")
                    .font(.headline)
                
                HStack {
                    Button("-") {
                        game.updateNumberOfDisks(game.numberOfDisks - 1)
                    }
                    .buttonStyle(ControlButtonStyle())
                    .disabled(game.numberOfDisks <= 1)
                    
                    Spacer()
                    
                    Button("+") {
                        game.updateNumberOfDisks(game.numberOfDisks + 1)
                    }
                    .buttonStyle(ControlButtonStyle())
                    .disabled(game.numberOfDisks >= 8)
                }
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            
            // Game controls
            VStack(spacing: 15) {
                Button("Auto Solve") {
                    game.autoSolve()
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(game.isAnimating || game.gameCompleted)
                
                Button("Reset Game") {
                    game.resetGame()
                }
                .buttonStyle(SecondaryButtonStyle())
                .disabled(game.isAnimating)
            }
        }
    }
}
