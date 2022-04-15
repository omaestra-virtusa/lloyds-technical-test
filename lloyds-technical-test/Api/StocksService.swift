//
//  StocksService.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import Alamofire

protocol StocksServiceProtocol {
    var network: NetworkingProtocol { get }
    
    func fetchLatestQuotes(symbols: [String],
                           completion: @escaping (Result<[Quote], APIError>) -> Void)
    func fetchIntradayData(symbols: [String],
                           interval: Constants.DateInterval,
                           completion: @escaping (Result<[IntradayModel], APIError>) -> Void)
}

final class StocksService: StocksServiceProtocol {
    var network: NetworkingProtocol
    
    init(network: NetworkingProtocol) {
        self.network = network
    }
    
    func fetchLatestQuotes(symbols: [String],
                           completion: @escaping (Result<[Quote], APIError>) -> Void) {
        network.execute(.stockData(symbols: symbols)) { (result: Result<APIResponseWrapper<[Quote]>?, APIError>) in
            switch result {
            case .success(let response):
                if let quotes = response?.data {
                    completion(.success(quotes))
                } else {
                    completion(.failure(APIError.genericError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchIntradayData(symbols: [String],
                           interval: Constants.DateInterval,
                           completion: @escaping (Result<[IntradayModel], APIError>) -> Void) {
        network.execute(.intradayData(symbols: symbols,
                                      interval: interval)) { (result: Result<APIResponseWrapper<[IntradayModel]>?, APIError>) in
            switch result {
            case .success(let response):
                if let intradayModel = response?.data {
                    completion(.success(intradayModel))
                } else{
                    completion(.failure(APIError.genericError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
