//
//  StocksListPresenter.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

protocol StocksListPresenterProtocol {
    var view: StocksViewProtocol? { get set }
    var quotes: [Quote]? { get }
    var service: StocksServiceProtocol { get }
    
    func fetchQuotes(for symbols: [String])
    func numberOfSectins() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getQuote(at indexPath: IndexPath) -> Quote?
}

class StocksListPresenter: StocksListPresenterProtocol {
    weak var view: StocksViewProtocol?
    
    var service: StocksServiceProtocol
    var quotes: [Quote]?
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    func fetchQuotes(for symbols: [String]) {
        service.fetchLatestQuotes(symbols: symbols, completion: { [weak self] result in
            switch result {
            case .success(let quotes):
                self?.quotes = quotes
                self?.view?.updateView()
            case .failure(let error):
                self?.quotes = nil
                self?.view?.displayError(title: error.code?.rawValue, description: error.message)
                debugPrint(error)
            }
        })
    }
    
    func numberOfSectins() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return quotes?.count ?? 0
    }
    
    func getQuote(at indexPath: IndexPath) -> Quote? {
        return quotes?[indexPath.row]
    }
}
