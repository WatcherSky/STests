//
//  CountriesListModel.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation


struct CountriesListModel: Codable {
    var flags: Flags
    var name: Name
    var capital: [String]?
    var population: Int
    var currencies: [String: Currencies]?
    var continents: [String]
    var cca2Code: String
    
    private enum CodingKeys : String, CodingKey {
        case flags, name, capital, population, continents, currencies, cca2Code = "cca2"
    }
}
