//
//  Networking.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import Alamofire

protocol NetworkingProtocol: AnyObject {
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void) -> Void
}

final class AlamofireNetworking: NetworkingProtocol {
    var request: Alamofire.Request?
    
    func execute<T>(_ endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        let decoder = JSONDecoder()
        
        request?.cancel()
        request = AF.request(endpoint)
            .validate()
            .responseDecodable(of: T.self, decoder: decoder) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    let apiError = APIError(code: .undefined,
                                            message: error.localizedDescription)
                    completion(.failure(apiError))
                }
            }
    }
}

final class MockNetworking: NetworkingProtocol {
    func execute<T: Decodable>(_ endpoint: Endpoint,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        loadJsonDataFromFile(endpoint.mockFileName ?? "") { result in
            do {
                let jsonDecoder = JSONDecoder()
                let decodedValue = try jsonDecoder.decode(T.self, from: result.get())
                completion(.success(decodedValue))
            } catch (let error) {
                debugPrint(error.localizedDescription)
                let apiError = APIError(code: .undefined,
                                        message: error.localizedDescription)
                completion(.failure(apiError))
            }
        }
    }
    
    internal func loadJsonDataFromFile(_ path: String,
                                       completion: @escaping (Result<Data, Error>) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(.success(data))
            } catch (let error) {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        } else {
            completion(.failure(APIError.genericError))
        }
    }
}
