//
//  MoviesListService.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import CoreNetwork
import Foundation

struct MoviesAPIEndpoint: APIEndpoint {
    var path: String {
        "/3/discover/movie"
    }
        
    var items: [String: String] {
        [
            "include_video": "false",
            "include_adult": "false",
            "language": "pt-BR"
        ]
    }
}

protocol MoviesListServicing {
    func fetchMovies() async throws -> MoviesResponse
}

struct MoviesListService: MoviesListServicing {
    private let network: CoreNetworking
    
    init(network: CoreNetworking = CoreNetwork()) {
        self.network = network
    }
    
    func fetchMovies() async throws -> MoviesResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = try await network.request(
            type: MoviesListService.Root.self,
            endpoint: MoviesAPIEndpoint(),
            decoder: decoder
        )
        
        return result.mapToResponse
    }
}

// MARK: Decodable models
private extension MoviesListService {
    struct Root: Decodable {
        let page: Int
        let results: [MovieDecodable]
        let totalPages: Int
        let totalResults: Int
    }
    
    struct MovieDecodable: Decodable {
        let id: Int
        let posterPath: String?
        let releaseDate: String
        let title: String
        let overview: String
    }
}

private extension MoviesListService.MovieDecodable {
    var movies: Movie {
        .init(
            id: id,
            imagePath: posterPath,
            release: releaseDate,
            title: title,
            overview: overview
        )
    }
}

private extension MoviesListService.Root {
    var mapToResponse: MoviesResponse {
        .init(
            page: page,
            results: results.map(\.movies),
            totalPages: totalPages,
            totalResults: totalResults
        )
    }
}
