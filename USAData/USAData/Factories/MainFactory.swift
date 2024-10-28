//
//  MainFactory.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

struct MainFactory {
    
    static func makeRootView(coordinator: AppCoordinator) -> RootView {
        RootView(coordinator: coordinator)
    }
    
    @MainActor
    static func makeNationsView(coordinator: AppCoordinator) -> NationsView {
        let networkService: NetworkServiceProtocol = NetworkService()
        let populationUseCase: PopulationUseCaseProtocol = PopulationUseCase(networkService: networkService)
        let nationsViewModel = NationsViewModel(populationUseCase: populationUseCase)
        nationsViewModel.delegate = coordinator
        
        return NationsView(viewModel: nationsViewModel)
    }
    
    @MainActor 
    static func makeStatesView(year: Int, coordinator: AppCoordinator) -> StatesView {
        let statesViewModel = StatesViewModel(year: year)
        statesViewModel.delegate = coordinator
        
        return StatesView(viewModel: statesViewModel)
    }
}
