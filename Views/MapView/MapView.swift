//
//  MapView.swift
//  FynoTravel
//
//  Created by Anton Shvets on 10.06.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var pins: [PinModel]
    @Binding var selectedCountry: Country?
    
    @State private var position: MapCameraPosition = .camera(
        .init(centerCoordinate: .init(), distance: 0)
    )
    @State private var keyframeAnimatorTrigger = false
    @State private var lastLocation: CLLocationCoordinate2D = .init()
    
    private let animationDuration = 0.75
    
    let distance: Double
    
    init(pins: Binding<[PinModel]>,
         distance: Double,
         selectedCountry: Binding<Country?> = .constant(nil)
    ) {
        self._pins = pins
        self.distance = distance
        self._selectedCountry = selectedCountry
    }
    
    var body: some View {
        Map(
            position: $position
        ) {
            ForEach(pins) { pin in
                Annotation("", coordinate: pin.location) {
                    PinView(model: pin.pinViewModel)
                }
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
        .onChange(of: pins) {
            position = .camera(
                MapCamera(
                    centerCoordinate: pins.first?.location ?? .init(),
                    distance: distance
                )
            )
        }
        .onChange(of: selectedCountry) {
            keyframeAnimatorTrigger.toggle()
        }
        .mapCameraKeyframeAnimator(trigger: keyframeAnimatorTrigger) { _ in
            let location = pins
                .first(where: { $0.pinViewModel.type == selectedCountry })?
                .location ?? pins.first?.location ?? .init()
            
            KeyframeTrack(\MapCamera.centerCoordinate) {
                LinearKeyframe(location, duration: animationDuration)
            }
            
            KeyframeTrack(\MapCamera.distance) {
                LinearKeyframe(distance/1.5, duration: animationDuration)
            }
        }
        .onMapCameraChange { camera in
            lastLocation = camera.region.center
        }
        .onTapGesture {
            withAnimation {
                self.position = .camera(
                    MapCamera(
                        centerCoordinate: lastLocation,
                        distance: distance
                    )
                )
            }
        }
        .animation(.easeInOut(duration: animationDuration), value: position)
    }
}

#Preview {
    VStack {
        MapView(
            pins: .constant(
                [.init(
                    location: .init(
                        latitude: 40.730610,
                        longitude: -73.935242),
                    pinViewModel: .init(
                        countryALPHACode: "US",
                        cityName: "New York",
                        completed: true)
                )]
            ),
            distance: 30000000
        )
        .frame(height: 400)
        Spacer()
    }
}
