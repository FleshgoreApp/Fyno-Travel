//
//  CountryCellViewModel.swift
//  FynoTravel
//
//  Created by Anton Shvets on 12.06.2024.
//

import Foundation

struct CountryCellViewModel: Identifiable {
    let id = UUID().uuidString
    let flagName: String
    let countryName: String
    let type: Country?
    
    init?(type: Country?) {
        guard let type else { return nil }
        self.flagName = type.flag
        self.countryName = type.countryName
        self.type = type
    }
}
