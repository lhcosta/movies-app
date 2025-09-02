//
//  CoreNetworkMock.swift
//  Movies
//
//  Created by Lucas Costa on 01/09/25.
//

import CoreNetwork
import Foundation
import Testing
@testable import Movies

final class CoreNetworkMock: CoreNetworking {
    var result: Result<Data, Error> = .failure(NetworkError.badURL)
    
    func request<Model: Decodable>(
        endpoint: any APIEndpoint,
        decoder: JSONDecoder
    ) async throws -> Model {
        switch result {
        case .success(let data):
            return try decoder.decode(Model.self, from: data)
        case .failure(let failure):
            throw failure
        }
    }
}


