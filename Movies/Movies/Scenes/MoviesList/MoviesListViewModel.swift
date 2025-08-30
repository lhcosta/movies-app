//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//
import SwiftUI

@Observable
final class MoviesListViewModel {
    var movies: [Movie] = []
    private let service: MoviesListServicing
    private var currentPage = 0
    
    init(service: MoviesListServicing = MoviesListService()) {
        self.service = service
    }
    
    @MainActor
    func fetch() async {
        do {
            let response = try await service.fetchMovies()
            currentPage = response.page
            movies = response.results
        } catch {
            print(error)
        }
    }
}
