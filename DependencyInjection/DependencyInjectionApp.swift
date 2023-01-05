//
//  DependencyInjectionApp.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI

@main
struct DependencyInjectionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(viewModel: HomeViewModel())
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        registerMockDependencies()
        #else
        registerDependencies()
        #endif
        return true
    }

    func registerDependencies() {
        Resolver.register(UserServiceProtocol.self) { _ in UserService() }
        Resolver.register(ClickerServiceProtocol.self) { _ in ClickerService() }
        Resolver.register(UserProviderProtocol.self) { _ in UserProvider() }
        Resolver.register(ClickerProviderProtocol.self) { _ in ClickerProvider() }
    }

    #if DEBUG
    func registerMockDependencies() {
        Resolver.register(UserServiceProtocol.self) { _ in UserServiceMock() }
        Resolver.register(ClickerServiceProtocol.self) { _ in ClickerServiceMock() }
        Resolver.register(UserProviderProtocol.self) { _ in UserProvider() }
        Resolver.register(ClickerProviderProtocol.self) { _ in ClickerProvider() }
    }
    #endif
}

struct Token {
    let key: String

    init(key: String) {
        self.key = key
    }
}
