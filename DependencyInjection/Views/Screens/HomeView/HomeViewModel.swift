//
//  HomeViewModel.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject, ProviderHandler {
    @Injected private var userProvider: UserProviderProtocol
    @Injected private var clickerProvider: ClickerProviderProtocol

    @Published private var userResult: ProviderResult<User> = .idle
    @Published private var clicksResult: ProviderResult<Int> = .idle

    var userName: ProviderResult<String> { userResult.map(\.name) }
    var clicks: ProviderResult<Int> { clicksResult }
   
    convenience init(userProvider: UserProviderProtocol, clickerProvider: ClickerProviderProtocol) {
        self.init()
        self.userProvider = userProvider
        self.clickerProvider = clickerProvider
    }

    func initialize() {
        clickerProvider.clicks.bind(to: &$clicksResult)
        userProvider.user.bind(to: &$userResult)
    }

    @discardableResult
    func fetchData() async -> (User, Int)? {
        async let user = try handle(into: \.userResult) { try await userProvider.getUser() }
        async let clicks = handle(into: \.clicksResult) { await clickerProvider.getClicks() }
        return try? await (user, clicks)
    }
}
