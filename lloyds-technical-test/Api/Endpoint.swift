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
    case intradayData(symbols: [String], interval: Constants.DateInterval)
    case news
}

extension Endpoint {
    var path: String {
        switch self {
        case .stockData:
            return "v1/data/quote"
        case .intradayData:
            return "v1/data/intraday"
        case .news:
            return "v1/news/all"
        }
    }
    
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .stockData, .intradayData, .news:
            return .get
        }
    }
    
    // MARK: - Parameters
    
    internal var parameters: Parameters? {
        var parameters: Parameters? = ["api_token": AppEnvironment.authToken]
        
        switch self {
        case .stockData(let symbols):
            parameters?["symbols"] = symbols.joined(separator: ",")
            
        case .intradayData(let symbols, let interval):
            parameters?["symbols"] = symbols.joined(separator: ",")
            parameters?["interval"] = interval.rawValue
            
        case .news:
            break
        }
        
        return parameters
    }
    
    var encoding: URLEncoding {
        switch self {
        case .stockData, .intradayData:
            return .queryString
        case .news:
            return .default
        }
    }
    
    var mockFileName: String? {
        switch self {
        case .news:
            return "mockNews"
        default:
            return nil
        }
    }
}
