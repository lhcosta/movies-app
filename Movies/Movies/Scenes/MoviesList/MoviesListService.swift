//
//  MoviesListService.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import CoreNetwork

struct MoviesAPIEndpoint: APIEndpoint {
    var path: String {
        "discover/movie"
    }
        
    var items: [String: Any] {
        [
            "include_video": "false",
            "include_adult": "false"
        ]
    }
}

struct MoviesListService {
    private let network: CoreNetworking
    
    init(network: CoreNetworking = CoreNetwork()) {
        self.network = network
    }
    
    func fetchMovies() async throws -> [Int] {
        try await network.request(type: [Int].self, endpoint: MoviesAPIEndpoint())
    }
}
