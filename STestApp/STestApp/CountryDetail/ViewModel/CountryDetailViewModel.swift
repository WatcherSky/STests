//
//  CountryDetailViewModel.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation

class CountryDetailViewModel {
    private let networkService: ICountryDetailService
    var dataProperties = ["Region", "Country Name", "Capital", "CapitalCoordinates", "Population", "Area", "Currencies", "Timezones"]
    
    private var country: Observable<[CountryDetailModel]> = Observable([])
    var countryData: [CountryDetailModel] = []
    var currencyList: [String] = []
    var cca2Code: String
    
    init(cca2Code: String, networkService: ICountryDetailService) {
        self.cca2Code = cca2Code
        self.networkService = networkService
    }
}

extension CountryDetailViewModel {
    func getCountry(code: String, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        networkService.getCountryDetail(code: code, completion: { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let countryData):
                self.country = Observable(countryData)
                success()
            case .failure(let error):
                failure(error)
            }
        })
    }
    
    func getData() {
        country.bind { country in
            self.countryData = country
        }
        
    }
    
    func transformCurrensies() {
        let _ = countryData.first?.currencies?.values.compactMap({ currency in
            if let symbol = currency.symbol {
                currencyList.append("\(currency.name)" + " " + "\(symbol)")
            }
        })
    }
}
