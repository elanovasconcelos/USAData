//
//  MockStatesViewModelDelegate.swift
//  USADataTests
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation
@testable import USAData

final class MockStatesViewModelDelegate: StatesViewModelDelegate {
    var needShowErrorCalled = false
    var receivedError: IdentifiableError?

    func statesViewModel(_ viewModel: StatesViewModel, needShowError error: IdentifiableError) {
        needShowErrorCalled = true
        receivedError = error
    }
}
