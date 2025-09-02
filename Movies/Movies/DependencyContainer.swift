//
//  DepedencyContainer.swift
//  Movies
//
//  Created by Lucas Costa on 02/09/25.
//

import CoreNetwork
import Storage
import SwiftUI

protocol DependencyResolving {
    func resolve<T>(_ type: T.Type) -> T
}

final class DependencyContainer: ObservableObject, DependencyResolving {
    static let shared = DependencyContainer()
    private var registrations = [String: Any]()

    private init() {
        register(CoreNetworking.self, instance: CoreNetwork())
        register(ImageMemoryCaching.self, instance: ImageMemoryCache())
    }

    private func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: T.self)
        registrations[key] = instance
    }

    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: T.self)
        guard let dependency = registrations[key] as? T else {
            fatalError("Sua dependência precisa ser injetada antes do uso - \(key)")
        }
        
        return dependency
    }
}
