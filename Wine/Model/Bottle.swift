//
//  Bottle.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import Foundation
import SwiftData

@Model
class Bottle {
    // SwiftData génère automatiquement l'ID, pas besoin de @Attribute(.primaryKey)
    var id: UUID
    var nom: String
    var type: String
    var annee: Int
    var imageURL: String?
    var quantite: Int
    var lieuAchat: String?
    var dateAjout: Date

    init(id: UUID = UUID(),
         nom: String,
         type: String,
         annee: Int,
         imageURL: String? = nil,
         quantite: Int,
         lieuAchat: String? = nil,
         dateAjout: Date = .now) {
        self.id = id
        self.nom = nom
        self.type = type
        self.annee = annee
        self.imageURL = imageURL
        self.quantite = quantite
        self.lieuAchat = lieuAchat
        self.dateAjout = dateAjout
    }
}
