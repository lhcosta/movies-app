//
//  MockDependencyResolver.swift
//  Movies
//
//  Created by Lucas Costa on 02/09/25.
//

@testable import Movies

final class MockDependencyContainer: DependencyResolving {
    var mockedDependencies: [String: Any] = [:]
    
    func mock<T>(_ type: T.Type, with instance: T) {
        let key = String(describing: T.self)
        mockedDependencies[key] = instance
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: T.self)
        
        guard let instance = mockedDependencies[key] as? T else {
            fatalError("Dependency not found for type: \(key)")
        }
        
        return instance
    }
}
