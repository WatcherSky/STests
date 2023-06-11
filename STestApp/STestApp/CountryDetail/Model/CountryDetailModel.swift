//
//  CountryDetailModel.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation

struct CountryDetailModel: Codable {
    var flags: Flags
    var subregion: String?
    var name: Name
    var capital: [String]?
    var capitalInfo: CapitalInfo?
    var population: Int
    var area: Double
    var currencies: [String: Currencies]?
    var timezones: [String]
}
