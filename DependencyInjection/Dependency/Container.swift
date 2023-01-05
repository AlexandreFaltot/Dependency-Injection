//
//  DependencyContainer.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

protocol Container {
    func register<T>(_ type: T.Type, _ registration: @escaping (Self) throws -> T) rethrows
    func resolve<T>(_ type: T.Type) throws -> T
}

extension Container {
    subscript<T>(type: T.Type) -> T? {
        try? resolve(type)
    }
}

final class SharedContainer: Container {
    private var container = [String: Any]()

    func register<T>(_ type: T.Type, _ registration: @escaping (SharedContainer) throws -> T) rethrows {
        container[String(describing: type)] = try? registration(self)
    }

    func resolve<T>(_ type: T.Type) throws -> T {
        guard let value = container[String(describing: type)] as? T else {
            throw ContainerError(message: "Can't resolve \(type) in container \(self)")
        }
        return value
    }
}

final class FactoryContainer: Container {
    private var container = [String: Any]()

    func register<T>(_ type: T.Type, _ registration: @escaping (FactoryContainer) throws -> T) rethrows {
        container[String(describing: type)] = registration
    }

    func resolve<T>(_ type: T.Type) throws -> T {
        guard let value = container[String(describing: type)] as? (FactoryContainer) throws -> T else {
            throw ContainerError(message: "Can't resolve \(type) in container \(self)")
        }

        return try value(self)
    }
}

struct ContainerError: Error {
    let message: String
}
