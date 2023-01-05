//
//  View+utils.swift
//  DependencyInjection
//
//  Created by Alexandre FALTOT on 23/09/2022.
//

import SwiftUI

extension View {
    func taskOnLoad(perform: @escaping () async -> Void) -> some View {
        modifier(TaskOnLoadViewModifier(perform: perform))
    }
}

struct TaskOnLoadViewModifier: ViewModifier {
    var perform: () async -> Void
    @State var didLoad: Bool = false

    func body(content: Content) -> some View {
        content
            .task {
                if !didLoad {
                    didLoad = true
                    await perform()
                }
            }
    }
}

