//
//  PinModel.swift
//  FynoTravel
//
//  Created by Anton Shvets on 10.06.2024.
//

import Foundation
import MapKit

struct PinModel: Identifiable, Equatable {
    static func == (lhs: PinModel, rhs: PinModel) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID().uuidString
    let location: CLLocationCoordinate2D
    let pinViewModel: PinViewViewModel
}
