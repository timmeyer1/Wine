//
//  WineApp.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI
import SwiftData

@main
struct WineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Bottle.self)
        }
    }
}
