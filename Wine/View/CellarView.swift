//
//  CellarView.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI
import SwiftData

struct CellarView: View {
    @Query(sort: \Bottle.dateAjout, order: .reverse) private var bottles: [Bottle]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {  // NavigationStack est recommandé dans SwiftUI moderne
            ZStack {
                List {
                    ForEach(bottles) { bottle in
                        NavigationLink {
                            BottleDetailView(bottle: bottle)
                        } label: {
                            HStack(spacing: 16) {
                                // Image de la bouteille
                                if let imageURL = bottle.imageURL, let url = URL(string: imageURL) {
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
                                    Text(bottle.nom)
                                        .font(.headline)
                                    Text("\(bottle.annee) - \(bottle.type)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("Quantité: \(bottle.quantite)")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteBottles)
                }
                .navigationTitle("Mon Cellier")
                
                // Bouton + flottant en bas à droite
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddBottleView()) {
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
    }

    private func deleteBottles(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(bottles[index])
        }
    }
}
