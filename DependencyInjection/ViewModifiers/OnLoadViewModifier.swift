//
//  View+utils.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 23/09/2022.
//

import SwiftUI

extension View {
    func onLoad(perform: @escaping () -> Void) -> some View {
        modifier(OnLoadViewModifier(perform: perform))
    }
}

struct OnLoadViewModifier: ViewModifier {
    var perform: () -> Void
    @State var didLoad: Bool = false

    func body(content: Content) -> some View {
        content
            .onAppear {
                if !didLoad {
                    perform()
                    didLoad = true
                }
            }
    }
}

