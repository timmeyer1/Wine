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
        NavigationStack {  // Changé pour NavigationStack comme dans CellarView
            ZStack {
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
                        NavigationLink {
                            WineDetailView(wine: wine)
                        } label: {
                            HStack(spacing: 16) {
                                // Image du vin
                                if let imageURL = wine.image, let url = URL(string: imageURL) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            // Image en cours de chargement
                                            Color.gray.opacity(0.3)
                                                .frame(width: 60, height: 60)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 60)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                
                                        case .failure:
                                            // Affichage en cas d'échec
                                            Color.red.opacity(0.3)
                                                .frame(width: 60, height: 60)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                
                                        @unknown default:
                                            // Au cas où un cas inconnu apparaisse
                                            Color.gray.opacity(0.3)
                                                .frame(width: 60, height: 60)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        }
                                    }
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    Color.gray.opacity(0.3)
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                                VStack(alignment: .leading) {
                                    Text(wine.wine)
                                        .font(.headline)
                                    Text(wine.winery ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    if let rating = wine.rating?.average {
                                        Text("⭐️ \(String(format: "%.1f", rating))")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .navigationTitle("Vins")
                
                // Bouton + flottant en bas à droite (si vous souhaitez l'ajouter)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // Action lorsque le bouton + est pressé
                            // Par exemple, ajouter un nouveau vin à la liste de favoris
                        }) {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
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
