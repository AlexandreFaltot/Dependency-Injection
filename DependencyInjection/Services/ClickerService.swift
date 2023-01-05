//
//  SharedService.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI
import Combine

protocol ClickerServiceProtocol {
    func increment() async -> Int
    func getClicks() async -> Int
}

class ClickerService: ClickerServiceProtocol {
    private var result: Int = 0

    func increment() async -> Int {
        result += 1
        return result
    }

    func getClicks() async -> Int {
        result
    }
}

#if DEBUG
class ClickerServiceMock: ClickerServiceProtocol {
    var result: Int = 1_000

    func increment() async -> Int {
        result += 2
        try? await Task.sleep(nanoseconds: 300_000_000)
        return result
    }

    func getClicks() async -> Int {
        try? await Task.sleep(nanoseconds: 300_000_000)
        return result
    }
}
#endif
