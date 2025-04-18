//
//  AddBottleView.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI
import SwiftData

struct AddBottleView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var nom = ""
    @State private var selectedType: WineType = .reds  // Type sélectionné par défaut
    @State private var annee = ""
    @State private var imageURL = ""
    @State private var quantite = "1"
    @State private var lieuAchat = ""

    var body: some View {
        Form {
            Section(header: Text("Informations sur la bouteille")) {
                TextField("Nom", text: $nom)
                
                // Picker pour le type de vin utilisant l'énumération WineType existante
                Picker("Type de vin", selection: $selectedType) {
                    ForEach(WineType.allCases, id: \.self) { wineType in
                        Text(wineType.label).tag(wineType)
                    }
                }
                
                TextField("Année", text: $annee)
                    .keyboardType(.numberPad)
                TextField("Image URL", text: $imageURL)
                TextField("Quantité", text: $quantite)
                    .keyboardType(.numberPad)
                TextField("Lieu d'achat", text: $lieuAchat)
            }

            Button("Ajouter la bouteille") {
                let newBottle = Bottle(
                    nom: nom,
                    type: selectedType.rawValue,  // Stocke la valeur brute de l'énumération
                    annee: Int(annee) ?? 0,
                    imageURL: imageURL.isEmpty ? nil : imageURL,
                    quantite: Int(quantite) ?? 1,
                    lieuAchat: lieuAchat.isEmpty ? nil : lieuAchat
                )
                context.insert(newBottle)
                try? context.save()
                dismiss()
            }
        }
        .navigationTitle("Nouvelle Bouteille")
    }
}
