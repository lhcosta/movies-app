//
//  ApiEndpoint.swift
//  CoreNetwork
//
//  Created by Lucas Costa on 30/08/25.
//

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var items: [String: String] { get }
}
