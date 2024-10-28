//
//  NationsViewModel.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import SwiftUI

protocol NationsViewModelDelegate: AnyObject {
    func nationsViewModel(_ viewModel: NationsViewModel, didSelectYear year: Int)
    func nationsViewModel(_ viewModel: NationsViewModel, needShowError error: IdentifiableError)
}

@MainActor
final class NationsViewModel: ObservableObject {
    @Published var nations: [NationPopulation] = []
    
    weak var delegate: NationsViewModelDelegate?
    
    private let populationUseCase: PopulationUseCaseProtocol
    
    init(populationUseCase: PopulationUseCaseProtocol = PopulationUseCase(networkService: NetworkService())) {
        self.populationUseCase = populationUseCase
    }
    
    func fetchNations() async {
        do {
            self.nations = try await populationUseCase.getNationPopulation()
        } catch {
            delegate?.nationsViewModel(self, needShowError: IdentifiableError(errorDescription: error.localizedDescription))
        }
    }
    
    func selectNation(nation: NationPopulation) {
        if let year = Int(nation.Year) {
            delegate?.nationsViewModel(self, didSelectYear: year)
        }
    }
}
