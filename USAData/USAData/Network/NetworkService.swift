//
//  NetworkService.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Codable>(endpoint: APIEndpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://datausa.io/api/data"
    
    func fetch<T: Codable>(endpoint: APIEndpoint) async throws -> T {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try validateResponse(response)
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
    }
}
