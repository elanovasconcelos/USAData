//
//  PopulationUseCase.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation

protocol PopulationUseCaseProtocol {
    func getStatePopulation(year: Int) async throws -> [StatePopulation]
    func getNationPopulation() async throws -> [NationPopulation]
}

final class PopulationUseCase: PopulationUseCaseProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getStatePopulation(year: Int) async throws -> [StatePopulation] {
        let response: StatePopulationResponse = try await networkService.fetch(endpoint: .statePopulation(year: year))
        return response.data
    }
    
    func getNationPopulation() async throws -> [NationPopulation] {
        let response: NationPopulationResponse = try await networkService.fetch(endpoint: .nationPopulation)
        return response.data
    }
}

