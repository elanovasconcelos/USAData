//
//  PopulationUseCaseTests.swift
//  USADataTests
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import XCTest
@testable import USAData

final class PopulationUseCaseTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var populationUseCase: PopulationUseCase!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        populationUseCase = PopulationUseCase(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        populationUseCase = nil
        super.tearDown()
    }
    
    func testGetNationPopulation_Success() async throws {
        // Given
        let data = try makeNationPopulationResponseData()
        mockNetworkService.fetchResult = .success(data)
        
        // When
        let result = try await populationUseCase.getNationPopulation()
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.Nation, "United States")
        XCTAssertEqual(result.first?.Population, 331000000)
    }
    
    func testGetNationPopulation_Failure() async {
        // Given
        mockNetworkService.fetchResult = .failure(.invalidResponse)
        
        // When & Then
        do {
            _ = try await populationUseCase.getNationPopulation()
            XCTFail("Expected to throw, but did not throw")
        } catch let error as NetworkError {
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidResponse.localizedDescription)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    func testGetStatePopulation_Success() async throws {
        // Given
        let data = try makeStatePopulationResponseData()
        mockNetworkService.fetchResult = .success(data)
        
        // When
        let result = try await populationUseCase.getStatePopulation(year: 2022)
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.State, "Alabama")
        XCTAssertEqual(result.first?.Population, 4903185)
    }
    
    func testGetStatePopulation_Failure() async {
        // Given
        mockNetworkService.fetchResult = .failure(.decodingFailed(NSError(domain: "", code: -1, userInfo: nil)))
        
        // When & Then
        do {
            _ = try await populationUseCase.getStatePopulation(year: 2022)
            XCTFail("Expected to throw, but did not throw")
        } catch let error as NetworkError {
            switch error {
            case .decodingFailed(_):
                XCTAssertTrue(true)
            default:
                XCTFail("Expected decodingFailed error, got: \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}

extension PopulationUseCaseTests {
    func makeNationPopulationResponse() -> NationPopulationResponse {
        let mockNation = [
            NationPopulation(
                IDNation: "01000US",
                Nation: "United States",
                IDYear: 2022,
                Year: "2022",
                Population: 331000000,
                SlugNation: "united-states"
            )
        ]
        
        return NationPopulationResponse(data: mockNation)
    }
    
    func makeNationPopulationResponseData() throws -> Data {
        try makeData(makeNationPopulationResponse())
    }
    
    func makeStatePopulationResponse() -> StatePopulationResponse {
        let mockStates = [
            StatePopulation(
                IDState: "01",
                State: "Alabama",
                IDYear: 2022,
                Year: "2022",
                Population: 4903185,
                SlugState: "alabama"
            )
        ]
        
        return StatePopulationResponse(data: mockStates)
    }
    
    func makeStatePopulationResponseData() throws -> Data {
        try makeData(makeStatePopulationResponse())
    }
    
    func makeData(_ object: Encodable) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(object)
    }
}
