//
//  NewsService.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation

protocol NewsServiceProtocol {
    var network: NetworkingProtocol { get }
    
    func fetchNews(completion: @escaping (Result<[News], APIError>) -> Void)
}

final class NewsService: NewsServiceProtocol {
    var network: NetworkingProtocol
    
    init(network: NetworkingProtocol) {
        self.network = network
    }
    
    func fetchNews(completion: @escaping (Result<[News], APIError>) -> Void) {
        network.execute(.news) { (result: Result<APIResponseWrapper<[News]>?, APIError>) in
            switch result {
            case .success(let response):
                if let news = response?.data {
                    completion(.success(news))
                } else {
                    completion(.failure(APIError.genericError))
                }
            case .failure(let error):
                completion(.failure(error))
            }

        }
    }
}
