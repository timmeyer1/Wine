//
//  ContentView.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WineListView()
                .tabItem {
                    Label("Vins", systemImage: "wineglass")
                }

            CellarView()
                .tabItem {
                    Label("Cellier", systemImage: "shippingbox.fill")
                }

            FriendsView()
                .tabItem {
                    Label("Amis", systemImage: "person.2.fill")
                }
        }
    }
}


#Preview {
    ContentView()
}
