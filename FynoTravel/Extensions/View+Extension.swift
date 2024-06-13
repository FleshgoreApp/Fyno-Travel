//
//  View+Extension.swift
//  FynoTravel
//
//  Created by Anton Shvets on 11.06.2024.
//

import SwiftUI

extension View {
    var hasHomeButton: Bool {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        guard let safeAreaBottom =  window?.safeAreaInsets.bottom else {
            return false
        }
        return safeAreaBottom <= 0
    }
}
