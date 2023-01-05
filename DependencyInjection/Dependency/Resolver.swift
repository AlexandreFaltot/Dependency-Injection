//
//  DependencyContainer.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

final class Resolver {
    private static let shared = Resolver()

    enum Scope: CaseIterable {
        case shared, factory

        ///
        /// Creates the container for the scope
        ///
        /// - Returns: The container for the scope
        ///
        func createContainer() -> any Container {
            switch self {
            case .shared: return SharedContainer()
            case .factory: return FactoryContainer()
            }
        }
    }

    private var containers: [Scope: any Container] = Scope.allCases.reduce(into: [:]) { $0[$1] = $1.createContainer() }

    subscript(scope: Scope) -> Container? {
        get { containers[scope] }
        set { containers[scope] = newValue }
    }

    ///
    /// Registers a dependency for a given container
    ///
    /// - Parameters:
    ///   - type: The type of the dependency to register
    ///   - container: The container that will receive the dependency
    ///   - dependency: The dependency to register
    ///
    static func register<T>(_ type: T.Type = T.self, in scope: Scope = .shared, _ dependency: @escaping (Container) -> T) {
        shared[scope]?.register(type, dependency)
    }

    ///
    /// Resolves the depencendy for the given container
    ///
    /// - Parameter container: The container that will resolve the dependency
    /// - Returns: The found dependency
    ///
    static func resolve<T>(scope: Scope = .shared) -> T {
        guard let value = shared[scope]?[T.self] else {
            fatalError("Couldn't resolve \(T.self) in scope \(scope)")
        }

        return value
    }
}
