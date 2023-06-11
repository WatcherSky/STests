//
//  CountriesListApi.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation
import Moya

enum CountriesListAPI {
    case allCountries
}

extension CountriesListAPI: TargetType {
    var baseURL: URL {
        return Constants.Network.baseURL
    }
    var path: String {
        switch self {
        case .allCountries:
            return "/v3.1/all"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        switch self {
        case .allCountries:
            return .requestPlain
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return [:]
    }
    
    var parameters: [String: Any] {
        switch self {
        case .allCountries:
            return [:]
        }
    }
}
