//
//  DependencyContainer.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

typealias Scope = KeyPath<Resolver, any Container>

final class Resolver {
    private static let shared = Resolver()

    let shared: Container = SharedContainer()
    let factory: Container = FactoryContainer()

    subscript(_ scope: Scope) -> Container? {
        self[keyPath: scope]
    }

    ///
    /// Registers a dependency for a given container
    ///
    /// - Parameters:
    ///   - type: The type of the dependency to register
    ///   - container: The container that will receive the dependency
    ///   - dependency: The dependency to register
    ///
    static func register<T>(_ type: T.Type = T.self, in scope: Scope = \.shared, _ dependency: @escaping (Container) -> T) {
        shared[scope]?.register(type, dependency)
    }

    ///
    /// Resolves the depencendy for the given container
    ///
    /// - Parameter container: The container that will resolve the dependency
    /// - Returns: The found dependency
    ///
    static func resolve<T>(scope: Scope = \.shared) -> T {
        guard let value = shared[scope]?[T.self] else {
            fatalError("Couldn't resolve \(T.self) in scope \(scope)")
        }

        return value
    }
}
