//
//  SecondaryButtonStyle.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 26/08/25.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.3))
            .foregroundColor(.primary)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
