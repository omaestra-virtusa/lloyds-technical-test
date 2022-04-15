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
    var intradayData: [IntradayModel]? { get }
    var service: StocksServiceProtocol { get }
    
    func fetchQuotes(for symbols: [String])
    func fetchIntradayData(for symbols: [String], interval: Constants.DateInterval)
    func numberOfSectins() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getQuotes() -> [Quote]?
    func getQuote(at indexPath: IndexPath) -> Quote?
    func getIntradayData() -> [IntradayModel]?
    func getIntradayModel(at indexPath: IndexPath) -> IntradayModel?
}

class StocksListPresenter: StocksListPresenterProtocol {
    weak var view: StocksViewProtocol?
    
    internal var service: StocksServiceProtocol
    var quotes: [Quote]?
    var intradayData: [IntradayModel]?
    
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
    
    func fetchIntradayData(for symbols: [String],
                           interval: Constants.DateInterval) {
        service.fetchIntradayData(symbols: symbols,
                                  interval: interval) { [weak self] result in
            switch result {
            case .success(let intradayData):
                self?.intradayData = intradayData
                self?.view?.updateView()
            case .failure(let error):
                self?.quotes = nil
                self?.view?.displayError(title: error.code?.rawValue, description: error.message)
                debugPrint(error)
            }
        }
    }
    
    func numberOfSectins() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return quotes?.count ?? 0
    }
    
    func getQuotes() -> [Quote]? {
        return self.quotes
    }
    
    func getQuote(at indexPath: IndexPath) -> Quote? {
        return quotes?[indexPath.row]
    }
    
    func getIntradayData() -> [IntradayModel]? {
        return intradayData
    }
    
    func getIntradayModel(at indexPath: IndexPath) -> IntradayModel? {
        return intradayData?[indexPath.row]
    }
}
