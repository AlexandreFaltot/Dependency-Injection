//
//  UserProvider.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 22/09/2022.
//

import Combine

protocol UserProviderProtocol {
    var user: ProviderPublisher<User> { get }

    @discardableResult
    func getUser() async throws -> User
}

class UserProvider: UserProviderProtocol, ProviderHandler {
    @Injected var userService: UserServiceProtocol

    @Published private var _user: ProviderResult<User> = .idle

    var user: ProviderPublisher<User> { $_user.eraseToAnyPublisher() }

    func getUser() async throws -> User {
        try await handle(into: \._user) {
            try await userService.getData()
        }
    }
}
