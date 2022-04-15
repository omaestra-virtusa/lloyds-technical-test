//
//  APIError.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation

struct APIError: Error, Decodable {
    enum APIErrorCode: String, Decodable {
        case undefined
        case usageLimitReached = "usage_limit_reached"
    }
    
    let code: APIErrorCode?
    let message: String
    
    private enum CodingKeys: String, CodingKey {
        case error
    }
    
    private enum ErrorDataKeys: String, CodingKey {
        case code, message
    }
    
    init(code: APIErrorCode, message: String) {
        self.code = code
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let errorContainer = try container.nestedContainer(keyedBy: ErrorDataKeys.self, forKey: .error)
        self.code = try errorContainer.decodeIfPresent(APIErrorCode.self, forKey: .code)
        self.message = try errorContainer.decode(String.self, forKey: .message)
    }
}

extension APIError {
    static var genericError: APIError {
        return APIError(code: .undefined,
                        message: "A generic error has ocurred")
    }
}
