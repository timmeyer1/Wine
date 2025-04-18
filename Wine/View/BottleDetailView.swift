//
//  BottleDetailView.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI

struct BottleDetailView: View {
    let bottle: Bottle

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let url = URL(string: bottle.imageURL ?? "") {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Text(bottle.nom)
                    .font(.largeTitle)
                    .bold()

                Group {
                    Text("Type : \(bottle.type)")
                    Text("Année : \(bottle.annee)")
                    Text("Quantité : \(bottle.quantite)")
                    if let lieu = bottle.lieuAchat {
                        Text("Lieu d’achat : \(lieu)")
                    }
                    Text("Ajouté le : \(bottle.dateAjout.formatted(date: .abbreviated, time: .omitted))")
                }
                .font(.body)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Bouteille")
        .navigationBarTitleDisplayMode(.inline)
    }
}
