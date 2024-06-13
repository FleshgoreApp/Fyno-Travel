//
//  PrimaryButtonStyle.swift
//  FynoTravel
//
//  Created by Anton Shvets on 13.06.2024.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.6), value: UUID())
    }
}
