import Foundation

public protocol CoreNetworking {
    func request<Model: Decodable>(
        type: Model.Type,
        endpoint: APIEndpoint,
        decoder: JSONDecoder
    ) async throws -> Model
}

public final class CoreNetwork {
    
}
