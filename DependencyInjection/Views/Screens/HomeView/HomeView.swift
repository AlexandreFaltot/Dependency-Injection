//
//  HomeView.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 15/09/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        Group {
            VStack(spacing: .mediumSpacing) {
                ProviderLoader(value: viewModel.userName) {
                    Text($0)
                }
                ProviderLoader(value: viewModel.clicks) {
                    Text("Current clicks: \($0)")
                }

                NavigationLink("Go clicking !") {
                    ClickerView(viewModel: ClickerViewModel())
                }
            }
        }
        .taskOnLoad {
            viewModel.initialize()
            await viewModel.fetchData()
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeView(viewModel: HomeViewModel())
            }
        }
    }
}
#endif


