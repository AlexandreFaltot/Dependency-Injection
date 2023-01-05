//
//  ProviderResult.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 22/09/2022.
//

import Combine

typealias ProviderPublisher<T> = AnyPublisher<ProviderResult<T>, Never>

enum ProviderResult<T> {
    case idle
    case loading
    case success(value: T)
    case error(error: any Error)

    var value: T? {
        switch self {
        case .success(let value): return value
        default: return nil
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading, .idle: return true
        default: return false
        }
    }

    func map<Transformed>(_ transform: (T) -> Transformed) -> ProviderResult<Transformed> {
        switch self {
        case .idle: return .idle
        case .loading: return .loading
        case .success(let value): return .success(value: transform(value))
        case .error(let error): return .error(error: error)
        }
    }
}
