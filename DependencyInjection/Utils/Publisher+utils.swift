//
//  Publisher+utils.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 22/09/2022.
//

import Combine
import Foundation

extension Publisher where Failure == Never {
    func bind<T>(to publisher: inout Published<T>.Publisher, value transform: @escaping (Output) -> T) {
        receive(on: RunLoop.main)
            .map(transform)
            .assign(to: &publisher)
    }

    func bind(to publisher: inout Published<Output>.Publisher) {
        receive(on: RunLoop.main)
            .assign(to: &publisher)
    }
}

protocol ProviderHandler { }

extension ProviderHandler {
    @MainActor
    func handle<Value>(into keyPath: ReferenceWritableKeyPath<Self, ProviderResult<Value>>, _ block: () async throws -> Value) async rethrows -> Value {
        self[keyPath: keyPath] = .loading
        do {
            let result = try await block()
            self[keyPath: keyPath] = .success(value: result)
            return result
        } catch {
            self[keyPath: keyPath] = .error(error: error)
            throw error
        }
    }
}
