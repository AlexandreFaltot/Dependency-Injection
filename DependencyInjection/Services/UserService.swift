//
//  UserService.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI

struct User {
    var name: String
}

protocol UserServiceProtocol {
    func getData() async throws -> User
}

class UserService: UserServiceProtocol {
    func getData() async throws -> User {
        User(name: "Jean")
    }
}

#if DEBUG
class UserServiceMock: UserServiceProtocol {
    func getData() async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return User(name: "Jean")
    }
}
#endif
