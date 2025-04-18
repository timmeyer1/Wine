//
//  BottleRatingView.swift
//  Wine
//
//  Created by Stagiaire on 18/04/2025.
//

import SwiftUI
import SwiftData

struct BottleRatingView: View {
    @Bindable var bottle: Bottle
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var tempNote: Double
    @State private var tempCommentaire: String

    init(bottle: Bottle) {
        self.bottle = bottle
        _tempNote = State(initialValue: bottle.note ?? 3.0)
        _tempCommentaire = State(initialValue: bottle.commentaire ?? "")
    }

    var body: some View {
        Form {
            Section(header: Text("Note")) {
                VStack {
                    Slider(value: $tempNote, in: 0...5, step: 0.5)
                    Text("⭐️ \(String(format: "%.1f", tempNote)) / 5")
                        .font(.headline)
                }
                .padding(.vertical)
            }

            Section(header: Text("Commentaire")) {
                TextEditor(text: $tempCommentaire)
                    .frame(minHeight: 100)
            }

            Section {
                Button("Enregistrer") {
                    bottle.note = tempNote
                    bottle.commentaire = tempCommentaire
                    bottle.dateDegustation = Date()

                    try? context.save()
                    dismiss()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Dégustation")
        .navigationBarTitleDisplayMode(.inline)
    }
}
