//
//  NationPopulation.swift
//  USAData
//
//  Created by Elano Vasconcelos on 28/10/2024.
//

import Foundation

struct NationPopulation: Codable, Identifiable {
    var id: String { IDNation+Year }
    
    let IDNation: String
    let Nation: String
    let IDYear: Int
    let Year: String
    let Population: Int
    let SlugNation: String

    enum CodingKeys: String, CodingKey {
        case IDNation = "ID Nation"
        case Nation
        case IDYear = "ID Year"
        case Year
        case Population
        case SlugNation = "Slug Nation"
    }
}
