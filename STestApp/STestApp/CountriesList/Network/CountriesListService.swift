//
//  CountriesListService.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//
//

import Foundation
import Moya

protocol ICountriesListService {
    var provider: MoyaProvider<CountriesListAPI> { get }
    
    func getCountriesList(completion: @escaping (Result<[CountriesListModel], Error>) -> ())
}

class CountriesListService: ICountriesListService {
    var provider = MoyaProvider<CountriesListAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getCountriesList(completion: @escaping (Result<[CountriesListModel], Error>) -> ()) {
        request(target: .allCountries, completion: completion)
    }
}

private extension CountriesListService {
    private func request<T: Decodable>(target: CountriesListAPI, completion: @escaping (Result<[T], Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([T].self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

