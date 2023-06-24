//
//  FactoryViewControllers.swift
//  STestApp
//
//  Created by Владимир on 24.06.2023.
//

import Foundation
import UIKit

class FactoryViewControllers {
    func createCountriesListVC() -> CountriesListViewController {
        let viewModel = CountriesListViewModel(networkService: CountriesListService())
        let viewController = CountriesListViewController(viewModel: viewModel)
        return viewController
        
    }
    
    func createCountryDetailVC(cca2Code: String) -> CountryDetailViewController {
        let viewModel = CountryDetailViewModel(cca2Code: cca2Code, networkService: CountryDetailService())
        let viewController = CountryDetailViewController(viewModel: viewModel)
        return viewController
    }
}
