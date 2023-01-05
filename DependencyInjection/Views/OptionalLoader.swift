//
//  OptionalLoader.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI

struct ProviderLoader<T, LoadedView: View, ErrorView: View>: View {
    var value: ProviderResult<T>
    @ViewBuilder var loadedView: (T) -> LoadedView
    @ViewBuilder var error: ErrorView

    init(value: ProviderResult<T>, loadedView: @escaping (T) -> LoadedView) where ErrorView == Text {
        self.value = value
        self.loadedView = loadedView
        self.error = Text("An unexpected error occured")
    }

    var body: some View {
        Group {
            switch value {
            case .idle: EmptyView()
            case .loading: ProgressView()
            case .success(let value): loadedView(value)
            case .error: Text("error")
            }
        }
    }
}

