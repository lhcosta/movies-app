import Foundation

public enum NetworkError: Error, Equatable {
    case badURL
    case decodingError(String)
    case invalidResponse(_ status: Int)
}

public protocol CoreNetworking {
    func request<Model: Decodable>(
        endpoint: APIEndpoint,
        decoder: JSONDecoder
    ) async throws -> Model
}

public extension CoreNetworking {
    func request<Model: Decodable>(
        endpoint: APIEndpoint
    ) async throws -> Model {
        try await request(endpoint: endpoint, decoder: JSONDecoder())
    }
}

public final class CoreNetwork: CoreNetworking {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Model: Decodable>(
        endpoint: APIEndpoint,
        decoder: JSONDecoder
    ) async throws -> Model {
        guard let request = endpoint.urlRequest else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.invalidResponse(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(Model.self, from: data)
        } catch {
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
}
