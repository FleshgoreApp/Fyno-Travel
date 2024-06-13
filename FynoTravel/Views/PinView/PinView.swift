//
//  PinView.swift
//  FynoTravel
//
//  Created by Anton Shvets on 10.06.2024.
//

import SwiftUI

struct PinView: View {
    let model: PinViewViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            ZStack(alignment: .top) {
                Image("union")
                Text(model.flagName)
                    .offset(y: 16)
                    .scaleEffect(1.1)
                
                if model.completed {
                    completedView
                        .offset(x: 12, y: 7)
                }
            }
            .frame(width: 34, height: 40)
            
            Text(model.cityName)
                .foregroundStyle(.white)
                .font(.system(size: 10, weight: .bold))
        }
    }
    
    private var completedView: some View {
        Image(systemName: "checkmark.circle.fill")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, .fynoBlue)
            .font(.system(size: 13))
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: 1)
                    .padding(1)
            )
    }
}

#Preview {
    ZStack {
        Color.black
        PinView(model: .init(
            countryALPHACode: "UA",
            cityName: "Kyiv",
            completed: true)
        )
        .scaleEffect(4)
    }
    .ignoresSafeArea()
}

