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
        ImageURLFactory.make(path: movie.imagePath)
    }
    
    var title: String {
        movie.title
    }
}

enum MoviesListError: Error {
    case movieNotFound
}

enum MovieListViewState {
    case loading
    case success([MoviePresentable])
    case failure
    case empty
}

@Observable
final class MoviesListViewModel {
    private(set) var state: MovieListViewState = .empty
    private let service: MoviesListServicing
    
    @ObservationIgnored
    private var results: [Movie] = []
    
    init(service: MoviesListServicing) {
        self.service = service
    }
    
    @MainActor
    func fetch() async {
        do {
            state = .loading
            let response = try await service.fetchMovies()
            results = response.results
            let movies = response.results.map { MoviePresentable(movie: $0) }
            state = movies.isEmpty ? .empty : .success(movies)
        } catch {
            state = .failure
        }
    }
    
    func selectMovie(with id: Int) throws -> MovieDetails {        
        guard let movie = results.first(where: { $0.id == id }) else {
            throw MoviesListError.movieNotFound
        }
        
        return MovieDetails(
            imageURL: ImageURLFactory.make(path: movie.imagePath),
            description: movie.overview,
            title: movie.title,
            releaseDate: movie.release
        )
    }
}
