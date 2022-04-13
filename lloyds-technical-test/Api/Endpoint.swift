//
//  Endpoint.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import Alamofire

enum Endpoint: URLRequestBuilder {
    case stockData(symbols: [String])
}

extension Endpoint {
    var path: String {
        switch self {
        case .stockData:
            return "v1/data/quote"
        }
    }
    
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .stockData:
            return .get
        }
    }
    
    // MARK: - Parameters
    
    internal var parameters: Parameters? {
        switch self {
        case .stockData(let symbols):
            return [
                "api_token": AppEnvironment.authToken,
                "symbols": symbols.joined(separator: ","),
            ]
        }
    }
    
    var encoding: URLEncoding {
        switch self {
        case .stockData:
            return .queryString
        }
    }
}
