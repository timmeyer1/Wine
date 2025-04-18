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
    var id: UUID
    var nom: String
    var type: String
    var annee: Int
    var imageURL: String?
    var quantite: Int
    var lieuAchat: String?
    var dateAjout: Date

    // Nouvelle propriété : note de dégustation
    var note: Double?  // Note de 0.0 à 5.0
    var commentaire: String?
    var dateDegustation: Date?

    init(id: UUID = UUID(),
         nom: String,
         type: String,
         annee: Int,
         imageURL: String? = nil,
         quantite: Int,
         lieuAchat: String? = nil,
         dateAjout: Date = .now,
         note: Double? = nil,
         commentaire: String? = nil,
         dateDegustation: Date? = nil) {
        self.id = id
        self.nom = nom
        self.type = type
        self.annee = annee
        self.imageURL = imageURL
        self.quantite = quantite
        self.lieuAchat = lieuAchat
        self.dateAjout = dateAjout
        self.note = note
        self.commentaire = commentaire
        self.dateDegustation = dateDegustation
    }
}
