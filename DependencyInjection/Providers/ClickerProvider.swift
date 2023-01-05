//
//  ClickerProvider.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 22/09/2022.
//

import Combine

protocol ClickerProviderProtocol {
    var clicks: ProviderPublisher<Int> { get }

    @discardableResult
    func click() async -> Int?

    @discardableResult
    func getClicks() async -> Int
}

class ClickerProvider: ClickerProviderProtocol {
    @Injected var clickerService: ClickerServiceProtocol
    @Published private var _clicks: ProviderResult<Int> = .idle

    var clicks: ProviderPublisher<Int> { $_clicks.eraseToAnyPublisher() }

    func click() async -> Int? {
        _clicks = .loading
        _clicks = .success(value: await clickerService.increment())
        return _clicks.value
    }

    func getClicks() async -> Int {
        _clicks = .loading
        _clicks = .success(value: await clickerService.getClicks())
        return _clicks.value ?? 0
    }
}


