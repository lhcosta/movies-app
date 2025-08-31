//
//  ContentView.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import SwiftUI

struct MoviesListView: View {
    @State
    private var viewModel: MoviesListViewModel
    
    init(viewModel: MoviesListViewModel = MoviesListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let movies):
                ListView(movies: movies)
            case .failure:
                FailureView(message: "Falha ao buscar os filmes") {
                    Task {
                        await viewModel.fetch()
                    }
                }
            case .empty:
                NoMoviesFoundView()
            }
        }
        .navigationDestination(for: MoviePresentable.self) { movie in
            MovieDetailsViewRepresentable(
                details: viewModel.selectMovie(with: movie.id)
            )
        }
        .navigationTitle("Filmes")
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        MoviesListView(
            viewModel: .init(service: MoviesListServicePreview())
        )
    }
}

final class MoviesListServicePreview: MoviesListServicing {
    func fetchMovies() async throws -> MoviesResponse {
        .init(
            page: 1,
            results: [
                .init(
                    id: 1,
                    imagePath: "https://midias.imagemfilmes.com.br/capas/d536dc70-5e53-46d0-82ce-31a314f542c3_m.jpg?2025-07-31T13:42:56.347024",
                    release: .now,
                    title: "A Guerra dos Mundos",
                    overview: ""
                ),
                .init(
                    id: 2,
                    imagePath: "https://midias.imagemfilmes.com.br/capas/d536dc70-5e53-46d0-82ce-31a314f542c3_m.jpg?2025-07-31T13:42:56.347024",
                    release: .now,
                    title: "A Guerra dos Mundos",
                    overview: ""
                ),
                .init(
                    id: 3,
                    imagePath: "https://midias.imagemfilmes.com.br/capas/d536dc70-5e53-46d0-82ce-31a314f542c3_m.jpg?2025-07-31T13:42:56.347024",
                    release: .now,
                    title: "A Guerra dos Mundos",
                    overview: ""
                ),
                .init(
                    id: 4,
                    imagePath: "https://midias.imagemfilmes.com.br/capas/d536dc70-5e53-46d0-82ce-31a314f542c3_m.jpg?2025-07-31T13:42:56.347024",
                    release: .now,
                    title: "A Guerra dos Mundos",
                    overview: ""
                ),
                .init(
                    id: 5,
                    imagePath: "https://midias.imagemfilmes.com.br/capas/d536dc70-5e53-46d0-82ce-31a314f542c3_m.jpg?2025-07-31T13:42:56.347024",
                    release: .now,
                    title: "A Guerra dos Mundos",
                    overview: ""
                )
            ],
            totalPages: 2,
            totalResults: 30
        )
    }
}
