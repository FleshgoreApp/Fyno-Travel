//
//  MainView.swift
//  FynoTravel
//
//  Created by Anton Shvets on 11.06.2024.
//

import SwiftUI
import MapKit

struct MainView: View {
    @StateObject var viewModel: ViewModel
    @State private var isInitialOffsetSet = false
    @State private var offset: CGFloat = .zero
    @State private var maxOffset: CGFloat = .zero
    @State private var minOffset: CGFloat = 20
    @State private var bottomSheetExpanded = false
    
    private let avatarOffsetY: CGFloat = 16
    private let additionalOffsetY: CGFloat = 43
    private let mapHeightAspect: CGFloat = 2.1
    private var mapZoom: CGFloat {
        hasHomeButton ? 90000 : 75000
    }
    
    var body: some View {
        GeometryReader { geo in
            let mapHeight = geo.size.height/mapHeightAspect
            let listHeight = bottomSheetExpanded
            ? geo.size.height - minOffset - additionalOffsetY
            : geo.size.height - mapHeight
            
            ZStack {
                ZStack(alignment: .top) {
                    bottomSheetBackground
                        .offset(y: avatarOffsetY)
                    
                    VStack(spacing: .zero) {
                        userView
                        
                        countriesInfoView
                        
                        Divider()
                        
                        contriesList
                            .frame(height: listHeight)
                    }
                    .padding(.horizontal, 24)
                }
                .offset(y: offset)
                .gesture(
                    gesture(height: mapHeight/3)
                )
            }
            .background {
                VStack {
                    MapView(
                        pins: $viewModel.pins,
                        distance: mapHeight * mapZoom,
                        selectedCountry: $viewModel.selectedCountry
                    )
                    .frame(height: mapHeight)
                    Spacer()
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                if !isInitialOffsetSet {
                    isInitialOffsetSet = true
                    offset = mapHeight - additionalOffsetY
                    maxOffset = mapHeight - additionalOffsetY
                }
            }
        }
        .task {
            viewModel.fetchPins()
        }
    }
    
    private var bottomSheetBackground: some View {
        ZStack {
            Color.white
                .roundedCorner(16, corners: [.topLeft, .topRight])
        }
    }
    
    private var userView: some View {
        HStack(spacing: 20) {
            VStack {
                Image("user")
                    .resizable()
                    .overlay(
                        Circle()
                            .stroke(.white, lineWidth: 4)
                    )
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Spacer()
                HStack(spacing: 4) {
                    Text("John Doe")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Button {
                        //some action
                    } label: {
                        Image("pencil")
                            .resizable()
                    }
                    .frame(width: 24, height: 24)
                }
                Text("Globe-trotter, fearless adventurer, cultural enthusiast, storyteller")
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .frame(height: 92)
        .frame(maxWidth: .infinity)
    }
    
    private var countriesInfoView: some View {
        HStack {
            VStack {
                Text("\(viewModel.countOfVisitedCountries)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("countries")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 36)
            
            VStack {
                Text(viewModel.countWorld)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("world")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 93)
    }
    
    private var contriesList: some View {
        ScrollView {
            VStack(spacing: .zero) {
                CountryView(
                    title: "I've been to",
                    contries: viewModel.visitedCountriesList
                ) { country in
                    viewModel.onSelectCountry(country)
                }
                .padding(.vertical, 10)
                
                Divider()
                
                CountryView(
                    title: "My bucket list",
                    contries: viewModel.bucketList
                ) { country in
                    viewModel.onSelectCountry(country)
                }
                .padding(.vertical, 10)
            }
        }
        .contentMargins(.bottom, 150, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
    
    private func gesture(height: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                let newOffset = value.startLocation.y + value.translation.height
                
                guard newOffset <= maxOffset && newOffset >= minOffset else {
                    return
                }
                
                bottomSheetExpanded = newOffset < offset
                
                withAnimation(.linear(duration: 0.3)) {
                    offset = newOffset
                }
            }
            .onEnded { value in
                withAnimation(.linear(duration: 0.3)) {
                    offset = bottomSheetExpanded ? minOffset : maxOffset
                }
            }
    }
}

#Preview {
    MainView(viewModel: .init())
}
