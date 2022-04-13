//
//  AppEnvironement.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

enum AppEnvironment {
    static var baseURL: URL { return URL(string: "https://api.stockdata.org")! }
    static var authToken: String { return "8FD0x2J2U0CTAWjD85JfVvENajYvW0ZkIbNsG3dA" }
}
