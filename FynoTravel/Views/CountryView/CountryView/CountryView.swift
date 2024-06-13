//
//  CountryView.swift
//  FynoTravel
//
//  Created by Anton Shvets on 12.06.2024.
//

import SwiftUI

struct CountryView: View {
    let title: String
    let contries: [CountryCellViewModel]
    let onSelect: (CountryCellViewModel) -> Void
    
    init(title: String, contries: [CountryCellViewModel], onSelect: @escaping (CountryCellViewModel) -> Void) {
        self.title = title
        self.contries = contries
        self.onSelect = onSelect
    }
    
    @State private var isExpanded = false
    private var items: [CountryCellViewModel] {
        isExpanded ? contries : Array(contries.prefix(3))
    }
    private var shouldShowMoreButton: Bool {
        return contries.count > 3
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            addCountryView
            
            LazyVStack(spacing: .zero) {
                ForEach(items) { country in
                    Button {
                        onSelect(country)
                    } label: {
                        CountryCell(model: country)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            
            if shouldShowMoreButton {
                moreView
            }
        }
    }
    
    private var addCountryView: some View {
        HStack {
            Text(title)
                .font(.body)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                //Some action
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.indigo)
                    
                    Text("Add country")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.indigo)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.fynoGray)
                .clipShape(.capsule)
            }
        }
        .frame(height: 48)
    }
    
    private var moreView: some View {
        let imageName = isExpanded ? "chevron.up" : "chevron.down"
        let seeMoreCount = contries.count - 3
        let title = isExpanded ? "Hide" : "See \(seeMoreCount) more"
        
        return HStack {
            Button {
                withAnimation(.spring(duration: 0.6)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 14) {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(.secondary)
                    
                    Text(title)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 8)
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .frame(height: 48)
    }
}

#Preview {
    CountryView(title: "My bucket list", contries: [
        .init(type: .CU),
        .init(type: .MX),
        .init(type: .AR),
        .init(type: .IS),
        .init(type: .US),
        .init(type: .UA)
    ].compactMap { $0 }) { country in
        
    }
}
