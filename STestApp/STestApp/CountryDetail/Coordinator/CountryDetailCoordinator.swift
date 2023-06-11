//
//  CountryDetailCoordinator.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation
import UIKit

protocol CountryDetailFlow: AnyObject {
    
}

class CountryDetailCoordinator: Coordinator, CountryDetailFlow {
    
    weak var navigationController: UINavigationController?
    var cca2Code: String
    
    init(cca2Code: String, navigationController: UINavigationController) {
        self.cca2Code = cca2Code
        self.navigationController = navigationController
    }
    
    func start() {
        let networkService = CountryDetailService()
        let viewModel = CountryDetailViewModel(cca2Code: cca2Code, networkService: networkService)
        let countryViewController = CountryDetailViewController(viewModel: viewModel)
        countryViewController.coordinator = self
        navigationController?.pushViewController(countryViewController, animated: true)
    }
}
