//
//  ViewController.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = StocksService(network: AlamofireNetworking())
        service.fetchLatestQuotes(symbols: ["AAPL"]) { result in
            print(result)
        }
    }
}

