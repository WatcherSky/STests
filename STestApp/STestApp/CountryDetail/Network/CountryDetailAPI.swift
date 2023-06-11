//
//  CountryDetailAPI.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//
//
import Foundation
import Moya

enum CountryDetailAPI {
    case country(String)
}

extension CountryDetailAPI: TargetType {
    var baseURL: URL {
        return Constants.Network.baseURL
    }
    var path: String {
        switch self {
        case .country(let code):
            return "/v3.1/alpha/\(code)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        switch self {
        case .country:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
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
        case .country(let code):
            return ["code": code]
        }
    }
}
