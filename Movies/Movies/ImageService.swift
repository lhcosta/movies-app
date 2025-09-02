//
//  ImageService.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import CoreNetwork
import Foundation
import Storage
import SwiftUI

enum ImageURLFactory {
    static func make(path: String?) -> URL? {
        guard let path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(path)")
    }
}

protocol ImageServicing {
    func fetch(url: URL?) throws -> Image
    func save(image: Image, at url: URL?)
}

enum ImageError: Error {
    case fetch
    case createImage
}

final class ImageService: ImageServicing {
    private let cache: ImageMemoryCaching
    static let shared = ImageService()
    
    private init(cache: ImageMemoryCaching = ImageMemoryCache()) {
        self.cache = cache
    }
    
    func fetch(url: URL?) throws -> Image {
        guard let url else { throw NetworkError.badURL }
        return try cache.fetch(identifier: url.absoluteString)
    }
    
    func save(image: Image, at url: URL?) {
        guard let url else { return }
        
        Task {
            cache.save(
                identifier: url.absoluteString,
                value: .init(data: image)
            )
        }
    }
}
