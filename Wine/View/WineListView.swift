//
//  WineListView.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI

struct WineListView: View {
    @State private var selectedType: WineType = .reds
    @State private var wines: [Wine] = []
    @State private var searchText: String = ""
    private let apiService = WineAPIService()

    var body: some View {
        NavigationView {
            VStack {
                // Picker pour sélectionner le type de vin
                Picker("Type de vin", selection: $selectedType) {
                    ForEach(WineType.allCases, id: \.self) { type in
                        Text(type.label).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Barre de recherche
                TextField("Rechercher un vin...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // Liste des vins filtrés
                List(filteredWines) { wine in
                    NavigationLink(destination: WineDetailView(wine: wine)) {
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
            }
            .navigationTitle("Vins")
        }
        .onAppear {
            fetchWines(for: selectedType)
        }
        .onChange(of: selectedType) {
            fetchWines(for: selectedType)
        }
        .onChange(of: searchText) {
            if searchText.isEmpty {
                fetchWines(for: selectedType)
            } else {
                apiService.fetchAllWines { all in
                    wines = all.filter { $0.wine.lowercased().contains(searchText.lowercased()) }
                }
            }
        }
    }

    private var filteredWines: [Wine] {
        if searchText.isEmpty {
            return wines
        } else {
            return wines.filter { $0.wine.lowercased().contains(searchText.lowercased()) }
        }
    }

    private func fetchWines(for type: WineType) {
        apiService.fetchWines(of: type) { result in
            wines = result
        }
    }
}
