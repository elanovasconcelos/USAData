//
//  NationsViewModelTests.swift
//  USADataTests
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import XCTest
@testable import USAData

final class NationsViewModelTests: XCTestCase {
    
    var mockUseCase: MockPopulationUseCase!
    var mockDelegate: MockNationsViewModelDelegate!
    var viewModel: NationsViewModel!
    
    @MainActor 
    override func setUp() {
        super.setUp()
        mockUseCase = MockPopulationUseCase()
        mockDelegate = MockNationsViewModelDelegate()
        viewModel = NationsViewModel(populationUseCase: mockUseCase)
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        mockUseCase = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor
    func testFetchNations_Success() async throws {
        // Given
        let mockNations = [
            NationPopulation(
                IDNation: "01000US",
                Nation: "United States",
                IDYear: 2022,
                Year: "2022",
                Population: 331000000,
                SlugNation: "united-states"
            ),
            NationPopulation(
                IDNation: "02000US",
                Nation: "Canada",
                IDYear: 2022,
                Year: "2022",
                Population: 37742154,
                SlugNation: "canada"
            )
        ]
        mockUseCase.getNationPopulationResult = .success(mockNations)
        
        // When
        await viewModel.fetchNations()
        
        // Then
        XCTAssertEqual(viewModel.nations.count, 2)
        XCTAssertEqual(viewModel.nations.first?.Nation, "United States")
        XCTAssertEqual(viewModel.nations.last?.Nation, "Canada")
        XCTAssertFalse(mockDelegate.needShowErrorCalled)
    }
    
    @MainActor
    func testFetchNations_Failure() async {
        // Given
        mockUseCase.getNationPopulationResult = .failure(.invalidResponse)
        
        // When
        await viewModel.fetchNations()
        
        // Then
        XCTAssertTrue(viewModel.nations.isEmpty)
        XCTAssertTrue(mockDelegate.needShowErrorCalled)
        XCTAssertEqual(mockDelegate.receivedError?.errorDescription, NetworkError.invalidResponse.localizedDescription)
    }
    
    @MainActor
    func testSelectNation_CallsDelegate() {
        // Given
        let nation = NationPopulation(
            IDNation: "03000US",
            Nation: "Mexico",
            IDYear: 2022,
            Year: "2022",
            Population: 128932753,
            SlugNation: "mexico"
        )
        
        // When
        viewModel.selectNation(nation: nation)
        
        // Then
        XCTAssertTrue(mockDelegate.didSelectYearCalled)
        XCTAssertEqual(mockDelegate.selectedYear, 2022)
    }
    
    @MainActor
    func testSelectNation_InvalidYear_DoesNotCallDelegate() {
        // Given
        let nation = NationPopulation(
            IDNation: "04000US",
            Nation: "Invalid Year Nation",
            IDYear: 2022,
            Year: "invalid year",
            Population: 1000000,
            SlugNation: "invalid-year-nation"
        )
        
        // When
        viewModel.selectNation(nation: nation)
        
        // Then
        XCTAssertFalse(mockDelegate.didSelectYearCalled)
    }
}

