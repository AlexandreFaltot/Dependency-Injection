//
//  HomeView.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI

struct ClickerView: View {
    @StateObject var viewModel: ClickerViewModel

    var body: some View {
        VStack(spacing: .mediumSpacing) {
            ProviderLoader(value: viewModel.clicks) {
                Text("Clicks: \($0)")
            }
            Button("Click !") {
                Task { await viewModel.click() }
            }
        }
        .onLoad {
            viewModel.initialize()
        }
    }
}

#if DEBUG
struct ClickerView_Previews: PreviewProvider {
    static var previews: some View {
        ClickerView(viewModel: ClickerViewModel())
    }
}
#endif

extension CGFloat {
    static let mediumSpacing: CGFloat = 16.0
}
