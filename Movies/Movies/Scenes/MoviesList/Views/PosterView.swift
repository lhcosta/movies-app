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
    let details: PosterDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {            
            CachedAsyncImage(url: details.url) { result in
                switch result {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .tint(.gray)
                }
            }
            .frame(height: 250)
            
            Text(details.title)
                .font(.callout)
                .foregroundColor(.primary)
                .lineLimit(1)
                .bold()
        }
        .padding()
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
