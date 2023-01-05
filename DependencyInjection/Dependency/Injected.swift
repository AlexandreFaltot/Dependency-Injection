//
//  Injected.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

@propertyWrapper
struct Injected<T> {
    var wrappedValue: T

    init(_ scope: Resolver.Scope = .shared) {
        self.wrappedValue = Resolver.resolve(scope: scope)
    }
}
