//
//  CountriesListCoordinator.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation
import UIKit


protocol CountriesListFlow: AnyObject {
    func coordinateToCountry(cca2Code: String)
}

class CountriesListCoordinator: Coordinator, CountriesListFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkService = CountriesListService()
        let viewModel = CountriesListViewModel(networkService: networkService)
        let countriesListViewController = CountriesListViewController(viewModel: viewModel)
        countriesListViewController.coordinator = self
        navigationController.pushViewController(countriesListViewController, animated: true)
    }
    
    
    // MARK: - Flow Methods
    func coordinateToCountry(cca2Code: String) {
        let countryCoordinator = CountryDetailCoordinator(cca2Code: cca2Code, navigationController: navigationController)
        coordinate(to: countryCoordinator)
    }
}
