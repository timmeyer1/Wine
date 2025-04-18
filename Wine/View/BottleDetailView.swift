import SwiftUI

struct BottleDetailView: View {
    @Bindable var bottle: Bottle
    @Environment(\.modelContext) private var context
    @State private var showingRatingView = false
    @State private var imageHeight: CGFloat = 200  // Hauteur par défaut plus raisonnable

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {  // Espacement réduit
                // Section image avec taille contrôlée
                if let url = URL(string: bottle.imageURL ?? "") {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fit)  // Utiliser fit au lieu de fill
                        } else if phase.error != nil {
                            Color.red
                        } else {
                            Color.gray.opacity(0.2)
                        }
                    }
                    .frame(maxHeight: imageHeight)  // Hauteur maximale contrôlée
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                }

                // Informations principales
                VStack(alignment: .leading, spacing: 8) {  // Espacement réduit
                    Text(bottle.nom)
                        .font(.title)  // Taille réduite
                        .bold()
                        .padding(.bottom, 4)
                    
                    // Informations dans une grille pour économiser de l'espace
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 10) {
                        InfoRow(label: "Type", value: bottle.type)
                        InfoRow(label: "Année", value: String(bottle.annee))
                        InfoRow(label: "Quantité", value: String(bottle.quantite))
                        if let lieu = bottle.lieuAchat {
                            InfoRow(label: "Lieu d'achat", value: lieu)
                        }
                        InfoRow(label: "Ajouté le", value: bottle.dateAjout.formatted(date: .abbreviated, time: .omitted))
                    }
                }
                .padding(.horizontal)

                Divider()
                    .padding(.vertical, 8)

                // Section note
                VStack(alignment: .leading, spacing: 8) {
                    if let note = bottle.note {
                        HStack {
                            Text("⭐️ Note:")
                                .font(.headline)
                            Text("\(String(format: "%.1f", note)) / 5")
                                .fontWeight(.medium)
                        }

                        if let commentaire = bottle.commentaire {
                            Text("📝 Commentaire:")
                                .font(.headline)
                                .padding(.top, 4)
                            Text(commentaire)
                                .padding(.horizontal, 4)
                        }
                    } else {
                        Text("🧐 Pas encore noté.")
                            .italic()
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Noter cette bouteille") {
                        showingRatingView = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)
                }
                .padding(.horizontal)

                Spacer(minLength: 20)
            }
            .padding(.vertical)
        }
        .navigationTitle("Détails")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingRatingView) {
            BottleRatingView(bottle: bottle)
        }
    }
}

// Composant réutilisable pour les lignes d'information
struct InfoRow: View {
    var label: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label + ":")
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.subheadline)
        }
    }
}
