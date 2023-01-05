//
//  HomeView.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI
import Combine

class ClickerViewModel: ObservableObject {
    @Injected var provider: ClickerProviderProtocol

    @Published private var clicksResult: ProviderResult<Int> = .idle

    var clicks: ProviderResult<Int> { clicksResult }

    func initialize() {
        provider.clicks.bind(to: &$clicksResult)
    }

    func click() async {
        await provider.click()
    }
}
