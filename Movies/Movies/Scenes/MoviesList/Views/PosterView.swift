//
//  PosterView.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//
import SwiftUI

struct PosterDetails {
    let url: URL?
    let title: String
}

struct PosterView: View {
    private let imageSize: CGSize = .init(width: 200, height: 250)
    let details: PosterDetails
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            CachedAsyncImage(url: details.url) { result in
                switch result {
                case .empty:
                    ProgressView()
                        .foregroundStyle(.blue)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .tint(.accentColor)
                }
            }
            .cornerRadius(4)
            .frame(width: imageSize.width, height: imageSize.height)

            Text(details.title)
                .font(.callout)
                .foregroundColor(.accentColor)
                .lineLimit(1)
                .bold()
        }
        .padding()
        .frame(width: imageSize.width)
        .background(Color.black.opacity(0.4))
        .cornerRadius(8)
        .shadow(color: .gray, radius: 3, x: 0, y: 3)
    }
}

#Preview {
    PosterView(
        details: .init(
            url: .init(string: "https://midias.imagemfilmes.com.br/capas/d536dc70-5e53-46d0-82ce-31a314f542c3_m.jpg?2025-07-31T13:42:56.347024"),
            title: "A Guerra dos Mundos"
        )
    )
}
