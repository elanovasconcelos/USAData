//
//  StatesViewModelTests.swift
//  USADataTests
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import XCTest
@testable import USAData

final class StatesViewModelTests: XCTestCase {

    var mockUseCase: MockPopulationUseCase!
    var mockDelegate: MockStatesViewModelDelegate!
    var viewModel: StatesViewModel!

    @MainActor 
    override func setUp() {
        super.setUp()
        mockUseCase = MockPopulationUseCase()
        mockDelegate = MockStatesViewModelDelegate()
        viewModel = StatesViewModel(year: 2022, populationUseCase: mockUseCase)
        viewModel.delegate = mockDelegate
    }

    override func tearDown() {
        mockUseCase = nil
        mockDelegate = nil
        viewModel = nil
        super.tearDown()
    }

    @MainActor
    func testFetchStates_Success() async throws {
        // Given
        let mockStates = [
            StatePopulation(
                IDState: "01",
                State: "Alabama",
                IDYear: 2022,
                Year: "2022",
                Population: 4903185,
                SlugState: "alabama"
            ),
            StatePopulation(
                IDState: "02",
                State: "Alaska",
                IDYear: 2022,
                Year: "2022",
                Population: 731545,
                SlugState: "alaska"
            )
        ]
        mockUseCase.getStatePopulationResult = .success(mockStates)

        // When
        await viewModel.fetchStates()

        // Then
        XCTAssertEqual(viewModel.states.count, 2, "states should contain 2 items after successful fetch.")
        XCTAssertEqual(viewModel.states.first?.State, "Alabama", "First state should be Alabama.")
        XCTAssertEqual(viewModel.states.last?.State, "Alaska", "Last state should be Alaska.")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data.")
        XCTAssertFalse(mockDelegate.needShowErrorCalled, "Delegate should not be called on successful fetch.")
    }

    @MainActor
    func testFetchStates_Failure() async {
        // Given
        mockUseCase.getStatePopulationResult = .failure(.invalidResponse)

        // When
        await viewModel.fetchStates()

        // Then
        XCTAssertTrue(viewModel.states.isEmpty, "states should be empty on fetch failure.")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch failure.")
        XCTAssertTrue(mockDelegate.needShowErrorCalled, "Delegate should be called on fetch failure.")
        XCTAssertEqual(mockDelegate.receivedError?.errorDescription, NetworkError.invalidResponse.localizedDescription, "Error description should match the thrown error.")
    }
}

