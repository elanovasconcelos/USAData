//
//  MockPopulationUseCase.swift
//  USADataTests
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation
@testable import USAData

final class MockPopulationUseCase: PopulationUseCaseProtocol {
    var getNationPopulationResult: Result<[NationPopulation], NetworkError>?
    var getStatePopulationResult: Result<[StatePopulation], NetworkError>?
    
    func getStatePopulation(year: Int) async throws -> [StatePopulation] {
        switch getStatePopulationResult {
        case .success(let states):
            return states
        case .failure(let error):
            throw error
        case .none:
            throw NetworkError.invalidResponse
        }
    }
    
    func getNationPopulation() async throws -> [NationPopulation] {
        switch getNationPopulationResult {
        case .success(let nations):
            return nations
        case .failure(let error):
            throw error
        case .none:
            throw NetworkError.invalidResponse
        }
    }
}
