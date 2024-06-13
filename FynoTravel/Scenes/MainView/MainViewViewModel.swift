//
//  MainViewViewModel.swift
//  FynoTravel
//
//  Created by Anton Shvets on 11.06.2024.
//

import Foundation
import Combine

extension MainView {
    
    final class ViewModel: ObservableObject {
        @Published var pins: [PinModel] = []
        @Published var visitedCountriesList: [CountryCellViewModel] = []
        @Published var bucketList: [CountryCellViewModel] = []
        @Published var countOfVisitedCountries = 0
        @Published var countWorld = "0"
        @Published var selectedCountry: Country?
        
        private var subscriptions = Set<AnyCancellable>()
        
        init() {
            addSubscriptions()
        }
        
        func fetchPins() {
            pins = [
                .init(
                    location: .init(
                        latitude: 40.730610,
                        longitude: -73.935242),
                    pinViewModel: .init(
                        countryALPHACode: "US",
                        cityName: "New York",
                        completed: true)
                ),
                .init(
                    location: .init(
                        latitude: 50.430614,
                        longitude: 30.563962),
                    pinViewModel: .init(
                        countryALPHACode: "UA",
                        cityName: "Kyiv",
                        completed: true)
                ),
                .init(
                    location: .init(
                        latitude: 24.030707437183146,
                        longitude: -104.66091068647941),
                    pinViewModel: .init(
                        countryALPHACode: "MX",
                        cityName: "Durango",
                        completed: true)
                ),
                .init(
                    location: .init(
                        latitude: 22.154324,
                        longitude: -80.442813),
                    pinViewModel: .init(
                        countryALPHACode: "CU",
                        cityName: "Cienfuegos",
                        completed: true)
                ),
                .init(
                    location: .init(
                        latitude: 63.417409,
                        longitude: -19.007188),
                    pinViewModel: .init(
                        countryALPHACode: "IS",
                        cityName: "Vik",
                        completed: true)
                ),
                .init(
                    location: .init(
                        latitude: -32.970330,
                        longitude: -60.665401),
                    pinViewModel: .init(
                        countryALPHACode: "AR",
                        cityName: "Rosario")
                ),
                .init(
                    location: .init(
                        latitude: -12.059523,
                        longitude: -76.989677),
                    pinViewModel: .init(
                        countryALPHACode: "PE",
                        cityName: "Lima",
                        completed: true)
                ),
                .init(
                    location: .init(
                        latitude: 40.847436,
                        longitude: 14.268998),
                    pinViewModel: .init(
                        countryALPHACode: "IT",
                        cityName: "Napoli")
                )
            ]
        }
        
        func onSelectCountry(_ country: CountryCellViewModel) {
            selectedCountry = country.type
        }
        
        func addSubscriptions() {
            $pins
                .dropFirst()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] pins in
                    guard let self else { return }
                    
                    let visitedCountries = pins
                        .filter { $0.pinViewModel.completed }
                        .count
                    self.countOfVisitedCountries = visitedCountries
                    self.countWorld = "\(Int(Float(visitedCountries)/Float(Country.totalCountries) * 100.0))%"
                    
                    self.visitedCountriesList = pins
                        .filter { $0.pinViewModel.completed }
                        .compactMap { .init(type: $0.pinViewModel.type) }
                    
                    self.bucketList = pins
                        .filter { !$0.pinViewModel.completed }
                        .compactMap { .init(type: $0.pinViewModel.type) }
                }
                .store(in: &subscriptions)
        }
    }
}
