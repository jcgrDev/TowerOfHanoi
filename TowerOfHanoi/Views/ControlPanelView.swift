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
            
            // Cloud integration control
            VStack {
                Text("Cloud Features")
                    .font(.headline)
                
                HStack {
                    Image(systemName: game.cloudService.isConnectd ? "cloud.fill" : "desktopcomputer")
                        .foregroundColor(game.cloudService.isConnectd ? .green : .red)
                    
                    Text(game.cloudService.isConnectd ? "Connected" : "Offline")
                }
                
                Toggle("Prefer Cloud Solution", isOn: $game.preferCloudSolution)
                    .onChange(of: game.preferCloudSolution) {
                        // Regenerate solution when preference changes
                        Task {
                            if game.preferCloudSolution && !game.cloudService.hasBeenTested {
                                await game.cloudService.testConnection()
                            }
                            await game.refreshSolution()
                        }
                    }
                
                if game.isLoadingCloudSolution {
                    HStack {
                        ProgressView()
                            .scaleEffect(0.8)
                        Text("Loading cloud solution ...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
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
            
            Button(game.showingSolution ? "Hide Solution" : "Show Solution") {
                game.showingSolution.toggle()
            }
            .buttonStyle(SecondaryButtonStyle())
            
            if game.showingSolution, let solution = game.solution {
                ScrollView {
                    LazyVStack(alignment: .leading , spacing: 5) {
                        Text("Solution Steps:")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        ForEach(Array(solution.moves.enumerated()), id: \.element.id) { index, move in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(index + 1).")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .frame(width: 25, alignment: .leading)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(move.description)
                                        .font(.caption)
                                        .foregroundColor(index < game.currentStep ? .green : .primary)
                                        .fontWeight(index == game.currentStep && game.isAnimating ? .bold : .regular)
                                    
                                    if index == game.currentStep && game.isAnimating {
                                        Text("<- Current Step")
                                            .font(.caption2)
                                            .foregroundColor(.blue)
                                            .italic()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
