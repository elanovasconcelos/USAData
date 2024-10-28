//
//  MockNetworkService.swift
//  USADataTests
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

// Tests/YourAppTests/MockNetworkService.swift
import Foundation
@testable import USAData

final class MockNetworkService: NetworkServiceProtocol {
    var fetchResult: Result<Data, NetworkError>?
    
    func fetch<T>(endpoint: APIEndpoint) async throws -> T where T : Decodable {
        guard let result = fetchResult else {
            throw NetworkError.invalidResponse
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        case .failure(let error):
            throw error
        }
    }
}

