//
//  Country.swift
//  FynoTravel
//
//  Created by Anton Shvets on 10.06.2024.
//

import Foundation

enum Country: String {
    case US //usa
    case UA //
    case IT //italy
    case MX //mexico
    case CU //cuba
    case PE //peru
    case AR //argentina
    case IS //island
    
    var flag: String {
        switch self {
        case .US: "🇺🇸"
        case .UA: "🇺🇦"
        case .IT: "🇮🇹"
        case .MX: "🇲🇽"
        case .CU: "🇨🇺"
        case .PE: "🇵🇪"
        case .AR: "🇦🇷"
        case .IS: "🇮🇸"
        }
    }
    
    var countryName: String {
        switch self {
        case .US: "United States of America"
        case .UA: "Ukraine"
        case .IT: "Italy"
        case .MX: "Mexico"
        case .CU: "Cuba"
        case .PE: "Peru"
        case .AR: "Argentina"
        case .IS: "Iceland"
        }
    }
    
    static var totalCountries: Int {
        195
    }
}
