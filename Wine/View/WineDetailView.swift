import SwiftUI

struct WineDetailView: View {
    let wine: Wine  // On passe un vin en paramètre

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Image du vin centrée
                if let imageUrl = wine.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 10)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                // Nom du vin
                Text(wine.wine)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.top, 16)
                
                // Vignoble
                if let winery = wine.winery {
                    Text("Vignoble: \(winery)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                
                // Description — toujours affichée
                VStack(alignment: .leading, spacing: 12) {
                    Text("À propos de ce vin :")
                        .font(.headline)
                        .foregroundColor(.primary)

                    if let description = wine.description, !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    } else {
                        Text("Aucune donnée pour le moment.")
                            .font(.body)
                            .italic()
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                }
                .padding(.top, 12)

                // Note
                if let rating = wine.rating {
                    VStack(alignment: .leading) {
                        Text("Note actuelle:")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.top, 12)
                        
                        if let average = rating.average {
                            Text("⭐️ \(String(format: "%.1f", average))")
                                .font(.title3)
                                .foregroundColor(.yellow)
                                .padding(.top, 4)
                        } else {
                            Text("⭐️ Non évalué")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .padding(.top, 4)
                        }
                    }
                    .padding(.top, 12)
                }

                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .navigationTitle("Détail du Vin")
        .navigationBarTitleDisplayMode(.inline)
    }
}
