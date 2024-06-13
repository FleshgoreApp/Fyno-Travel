//
//  PinViewViewModel.swift
//  FynoTravel
//
//  Created by Anton Shvets on 10.06.2024.
//

import Foundation

struct PinViewViewModel {
    let flagName: String
    let cityName: String
    let countryName: String
    let type: Country?
    let completed: Bool
    
    init(countryALPHACode: String, cityName: String, completed: Bool = false) {
        self.flagName = Country(rawValue: countryALPHACode)?.flag ?? ""
        self.cityName = cityName
        self.countryName = Country(rawValue: countryALPHACode)?.countryName ?? "Country name"
        self.type = Country(rawValue: countryALPHACode)
        self.completed = completed
    }
}
