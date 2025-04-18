//
//  WineType.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

enum WineType: String, CaseIterable {
    case reds, white, rose, sparkling

    var label: String {
        switch self {
        case .reds: return "Rouge"
        case .white: return "Blanc"
        case .rose: return "Rosé"
        case .sparkling: return "Pétillant"
        }
    }
}
