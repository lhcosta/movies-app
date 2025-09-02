//
//  MoviesListServiceTests.swift
//  Movies
//
//  Created by Lucas Costa on 01/09/25.
//

import CoreNetwork
import Foundation
import Testing
@testable import Movies

struct MoviesListServiceTests {
    struct Args {
        let coreNetworkMock: CoreNetworkMock
        let sut: MoviesListService
    }
    
    @Test(arguments: [NetworkError.badURL, .decodingError("Fail to decoding"), .invalidResponse(500)])
    func fetchMovies_WhenRequestFail_ShouldThrowError(_ error: NetworkError) async throws {
        let args = makeSut()
        
        args.coreNetworkMock.result = .failure(error)

        await #expect(throws: error) {
            try await args.sut.fetchMovies()
        }
    }
    
    @Test
    func fetchMovies_WhenRequestIsSuccess_ShouldReturnMovieResponse() async throws {
        let args = makeSut()
        let data = try #require(MoviesResponseFake.make())
        let expectedResponse = MoviesResponse.fixture()
        
        args.coreNetworkMock.result = .success(data)
        let response = try await args.sut.fetchMovies()
        
        #expect(response == expectedResponse)
    }
    
    // MARK: Helpers
    private func makeSut() -> Args {
        let container = MockDependencyContainer()
        let coreNetworkMock = CoreNetworkMock()
        container.mock(CoreNetworking.self, with: coreNetworkMock)
        
        let sut = MoviesListService(resolver: container)
        return .init(coreNetworkMock: coreNetworkMock, sut: sut)
    }
}

extension MoviesResponse {
    static func fixture() -> Self {
        .init(
            page: 1,
            results: [
                .init(
                    id: 1151334,
                    imagePath: "/12Va3oO3oYUdOd75zM57Nx1976a.jpg",
                    release: Date.make(from: "2025-08-21") ?? .now,
                    title: "Eenie Meanie",
                    overview: "A former teenage getaway driver gets dragged back into her unsavory past when a former employer offers her a chance to save the life of her chronically unreliable ex-boyfriend."
                )
            ]
        )
    }
}

extension Date {
    static func make(from value: String) -> Self? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: value)
    }
}
