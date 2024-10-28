//
//  AppCoordinator.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

struct IdentifiableError: Identifiable {
    var id: String { errorDescription }
    let errorDescription: String
}

enum NavigationDestination: Hashable {
    case states(year: Int)
}

protocol Coordinator: AnyObject {
    var navigationPath: Binding<NavigationPath> { get }
}

final class AppCoordinator: Coordinator, ObservableObject {
    @Published var path = NavigationPath()
    @Published var error: IdentifiableError?
    
    var navigationPath: Binding<NavigationPath> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }
    
    @MainActor func start() -> some View {
        makeInitialView()
    }

    @MainActor
    private func makeInitialView() -> some View {
        MainFactory.makeNationsView(coordinator: self)
    }
    
    private func navigate(to destination: NavigationDestination) {
        path.append(destination)
    }
}

extension AppCoordinator: NationsViewModelDelegate {
    func nationsViewModel(_ viewModel: NationsViewModel, didSelectYear year: Int) {
        navigate(to: .states(year: year))
    }

    func nationsViewModel(_ viewModel: NationsViewModel, needShowError error: IdentifiableError) {
        self.error = error
    }
}

extension AppCoordinator: StatesViewModelDelegate {
    func statesViewModel(_ viewModel: StatesViewModel, needShowError error: IdentifiableError) {
        self.error = error
    }
}
