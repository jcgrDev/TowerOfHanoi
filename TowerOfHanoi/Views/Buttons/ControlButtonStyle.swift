//
//  ControlButtonStyle.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 26/08/25.
//

import SwiftUI

struct ControlButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.bold)
            .padding()
            .frame(width: 50, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(25)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
