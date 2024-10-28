//
//  StatePopulation.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation

struct StatePopulation: Codable, Identifiable {
    var id: String { IDState }
    
    let IDState: String
    let State: String
    let IDYear: Int
    let Year: String
    let Population: Int
    let SlugState: String

    enum CodingKeys: String, CodingKey {
        case IDState = "ID State"
        case State
        case IDYear = "ID Year"
        case Year
        case Population
        case SlugState = "Slug State"
    }
}
