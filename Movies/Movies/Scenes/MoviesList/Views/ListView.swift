//
//  ListView.swift
//  Movies
//
//  Created by Lucas Costa on 31/08/25.
//

import SwiftUI

struct ListView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    let movies: [MoviePresentable]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        PosterView(
                            details: .init(
                                url: movie.url,
                                title: movie.title
                            )
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ListView(
        movies: [
            .init(movie: .init(id: 1, imagePath: nil, release: .now, title: "Teste", overview: "Teste")),
            .init(movie: .init(id: 2, imagePath: nil, release: .now, title: "Teste", overview: "Teste")),
            .init(movie: .init(id: 3, imagePath: nil, release: .now, title: "Teste", overview: "Teste")),
            .init(movie: .init(id: 4, imagePath: nil, release: .now, title: "Teste", overview: "Teste"))
        ]
    )
}
