//
//  MockNationsViewModelDelegate.swift
//  USADataTests
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation
@testable import USAData

final class MockNationsViewModelDelegate: NationsViewModelDelegate {
    var didSelectYearCalled = false
    var selectedYear: Int?
    
    var needShowErrorCalled = false
    var receivedError: IdentifiableError?
    
    func nationsViewModel(_ viewModel: NationsViewModel, didSelectYear year: Int) {
        didSelectYearCalled = true
        selectedYear = year
    }
    
    func nationsViewModel(_ viewModel: NationsViewModel, needShowError error: IdentifiableError) {
        needShowErrorCalled = true
        receivedError = error
    }
}
