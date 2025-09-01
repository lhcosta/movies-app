// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftUI

public protocol ImageMemoryCaching {
    func save(identifier: String, value: CacheData<Image>)
    func fetch(identifier: String) throws -> Image
}

enum CacheError: Error {
    case failToSave
    case failToFetch
}

public final class CacheData<Model> {
    let data: Model
    
    public init(data: Model) {
        self.data = data
    }
}

public final class ImageMemoryCache: ImageMemoryCaching {
    public typealias CacheImage = NSCache<NSString, CacheData<Image>>
    private let cache: CacheImage

    public init(cache: CacheImage = .init()) {
        self.cache = cache
    }
    
    public func save(identifier: String, value: CacheData<Image>) {
        cache.setObject(value, forKey: identifier as NSString)
    }
    
    public func fetch(identifier: String) throws -> Image {
        guard let object = cache.object(forKey: identifier as NSString) else { throw CacheError.failToFetch }
        return object.data
    }
}
