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
    case intradayData(symbols: [String])
}

extension Endpoint {
    var path: String {
        switch self {
        case .stockData:
            return "v1/data/quote"
        case .intradayData:
            return "v1/data/intraday"
        }
    }
    
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .stockData, .intradayData:
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
        case .intradayData(let symbols):
            return [
                "api_token": AppEnvironment.authToken,
                "symbols": symbols.joined(separator: ","),
                "interval": "day"
            ]
        }
    }
    
    var encoding: URLEncoding {
        switch self {
        case .stockData, .intradayData:
            return .queryString
        }
    }
}
