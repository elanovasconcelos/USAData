//
//  RootView.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        NavigationStack(path: coordinator.navigationPath) {
            coordinator.start()
                .alert(item: $coordinator.error) { error in
                    Alert(title: Text("Error"),
                          message: Text(error.errorDescription),
                          dismissButton: .default(Text("OK")))
                }
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .states(let year):
                        MainFactory.makeStatesView(year: year, coordinator: coordinator)
                    }
                }
        }
    }
}

