//
//  Wine.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import Foundation

struct Wine: Identifiable, Decodable {
    let id = UUID()
    let wine: String
    let winery: String?
    let rating: Rating?
    let image: String?

    struct Rating: Decodable {
        let average: Double?
        let reviews: String?

        enum CodingKeys: String, CodingKey {
            case average, reviews
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            // Convertir "average" de String à Double
            if let averageString = try? container.decode(String.self, forKey: .average),
               let averageValue = Double(averageString) {
                average = averageValue
            } else {
                average = nil
            }

            reviews = try? container.decode(String.self, forKey: .reviews)
        }
    }

    enum CodingKeys: String, CodingKey {
        case wine, winery, rating, image
    }
}
