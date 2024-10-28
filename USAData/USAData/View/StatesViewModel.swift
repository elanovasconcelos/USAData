//
//  StatesViewModel.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

protocol StatesViewModelDelegate: AnyObject {
    func statesViewModel(_ viewModel: StatesViewModel, needShowError error: IdentifiableError)
}

@MainActor
final class StatesViewModel: ObservableObject {
    @Published var states: [StatePopulation] = []
    @Published var isLoading: Bool = false
    
    weak var delegate: StatesViewModelDelegate?
    
    private let populationUseCase: PopulationUseCaseProtocol
    let year: Int
    
    init(year: Int, populationUseCase: PopulationUseCaseProtocol = PopulationUseCase(networkService: NetworkService())) {
        self.year = year
        self.populationUseCase = populationUseCase
    }
    
    func fetchStates() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.states = try await populationUseCase.getStatePopulation(year: year)
        } catch {
            delegate?.statesViewModel(self, needShowError: IdentifiableError(errorDescription: error.localizedDescription))
        }
    }
}

