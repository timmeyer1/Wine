//
//  WineListView.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI

struct WineListView: View {
    @State private var selectedType: WineAPIService.WineType = .reds
    @State private var wines: [Wine] = []
    private let apiService = WineAPIService()

    var body: some View {
        NavigationView {
            VStack {
                Picker("Type de vin", selection: $selectedType) {
                    ForEach(WineAPIService.WineType.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(wines) { wine in
                    HStack {
                        AsyncImage(url: URL(string: wine.image ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading) {
                            Text(wine.wine)
                                .font(.headline)
                            Text(wine.winery ?? "")
                                .font(.subheadline)
                            if let rating = wine.rating?.average {
                                Text("⭐️ \(String(format: "%.1f", rating))")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Vins")
        }
        .onAppear {
            fetchWines()
        }
        .onChange(of: selectedType) {
            fetchWines()
        }
    }

    private func fetchWines() {
        apiService.fetchWines(of: selectedType) { result in
            wines = result
        }
    }
}
