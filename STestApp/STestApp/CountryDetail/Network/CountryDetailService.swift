//
//  CountryDetailService.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation
import Moya

protocol ICountryDetailService {
    var provider: MoyaProvider<CountryDetailAPI> { get }
    
    func getCountryDetail(code: String, completion: @escaping (Result<[CountryDetailModel], Error>) -> ())
}

class CountryDetailService: ICountryDetailService {
    var provider = MoyaProvider<CountryDetailAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getCountryDetail(code: String, completion: @escaping (Result<[CountryDetailModel], Error>) -> ()) {
        request(target: .country(code), completion: completion)
    }
}

private extension CountryDetailService {
    private func request<T: Decodable>(target: CountryDetailAPI, completion: @escaping (Result<[T], Error>) -> ()) {
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

