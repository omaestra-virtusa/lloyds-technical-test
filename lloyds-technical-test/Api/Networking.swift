//
//  Networking.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import Alamofire

protocol NetworkingProtocol: AnyObject {
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) -> Void
}

final class AlamofireNetworking: NetworkingProtocol {
    func execute<T>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let decoder = JSONDecoder()
        AF.request(endpoint)
            .responseDecodable(of: T.self, decoder: decoder) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
