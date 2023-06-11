//
//  Constants.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation

enum Constants {
    enum Network {
        static let baseURL = URL(string: "https://restcountries.com")!
    }
    
    enum ReuseIdentifiers {
        static let countryCell = "countryCell"
        static let headerReusable = "header"
        
        static let detailCell = "detailCell"
    }
}
