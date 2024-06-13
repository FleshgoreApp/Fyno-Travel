//
//  CountryCell.swift
//  FynoTravel
//
//  Created by Anton Shvets on 12.06.2024.
//

import SwiftUI

struct CountryCell: View {
    let model: CountryCellViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            Text(model.flagName)
                .font(.title3)
            Text(model.countryName)
                .font(.body)
            Spacer()
        }
        .frame(height: 48)
    }
}

#Preview {
    CountryCell(model: .init(type: .UA)!)
}
