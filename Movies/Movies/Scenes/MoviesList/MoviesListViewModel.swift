//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//
import SwiftUI

struct MoviePresentable: Hashable, Identifiable {
    let id: Int
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        self.id = movie.id
    }
    
    var url: URL? {
        guard let imagePath = movie.imagePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(imagePath)")
    }
    
    var title: String {
        movie.title
    }
}

enum MoviesListError: Error {
    case movieNotFound
}

@Observable
final class MoviesListViewModel {
    var movies: [MoviePresentable] = []
    private let service: MoviesListServicing
    
    @ObservationIgnored
    private var results: [Movie] = []
    
    init(service: MoviesListServicing = MoviesListService()) {
        self.service = service
    }
    
    @MainActor
    func fetch() async {
        do {
            let response = try await service.fetchMovies()
            results = response.results
            movies = response.results.map { MoviePresentable(movie: $0) }
        } catch {
            print(error)
        }
    }
    
    func selectMovie(with id: Int) -> MovieDetails {
        let movie = results.first(where: { $0.id == id })!
        return MovieDetails(
            imageURL: movie.imagePath,
            description: movie.overview,
            title: movie.title,
            releaseDate: movie.release
        )
    }
}
