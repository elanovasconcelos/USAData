//
//  APIEndpoint.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation

enum APIEndpoint {
    case statePopulation(year: Int)
    case nationPopulation
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .statePopulation(let year):
            return [
                URLQueryItem(name: "drilldowns", value: "State"),
                URLQueryItem(name: "measures", value: "Population"),
                URLQueryItem(name: "year", value: "\(year)")
            ]
        case .nationPopulation:
            return [
                URLQueryItem(name: "drilldowns", value: "Nation"),
                URLQueryItem(name: "measures", value: "Population")
            ]
        }
    }
}

