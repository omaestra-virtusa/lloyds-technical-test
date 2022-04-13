//
//  APIResponseWrapper.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

struct APIResponseWrapper<Response: Decodable>: Decodable {
    let meta2: String?
    let data: Response
}
