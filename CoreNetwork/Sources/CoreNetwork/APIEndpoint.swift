//
//  ApiEndpoint.swift
//  CoreNetwork
//
//  Created by Lucas Costa on 30/08/25.
//
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var items: [String: String] { get }
    var body: Data? { get }
}

public extension APIEndpoint {
    var method: HTTPMethod { .get }
    var items: [String: String] { [:] }
    var body: Data? { nil }
}

extension APIEndpoint {
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.queryItems = items.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer \(APIToken.value)",
            "Content-Type": "application/json"
        ]
        
        return request
    }
}
