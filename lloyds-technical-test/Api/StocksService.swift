//
//  StocksService.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

protocol StocksServiceProtocol {
    var network: NetworkingProtocol { get }
    
    func fetchLatestQuotes(symbols: [String], completion: @escaping (Result<[Quote], Error>) -> Void)
}

final class StocksService: StocksServiceProtocol {
    var network: NetworkingProtocol
    
    init(network: NetworkingProtocol) {
        self.network = network
    }
    
    func fetchLatestQuotes(symbols: [String], completion: @escaping (Result<[Quote], Error>) -> Void) {
        network.execute(.stockData(symbols: symbols)) { (result: Result<APIResponseWrapper<[Quote]>?, Error>) in
            switch result {
            case .success(let response):
                if let quotes = response?.data {
                    completion(.success(quotes))
                } else{
                    completion(.failure(NSError()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
