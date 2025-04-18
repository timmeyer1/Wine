//
//  WineAPIService.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import Foundation

class WineAPIService {
    enum WineType: String, CaseIterable {
        case reds, white, rose, sparkling
    }

    func fetchWines(of type: WineType, completion: @escaping ([Wine]) -> Void) {
        guard let url = URL(string: "https://api.sampleapis.com/wines/\(type.rawValue)") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }

            do {
                let wines = try JSONDecoder().decode([Wine].self, from: data)
                DispatchQueue.main.async {
                    completion(wines)
                }
            } catch {
                print("Erreur décodage: \(error)")
                completion([])
            }
        }.resume()
    }
}
