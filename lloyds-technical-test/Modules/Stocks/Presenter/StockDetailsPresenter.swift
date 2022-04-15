//
//  StockDetailsPresenter.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 14/04/2022.
//

import Foundation

protocol StockDetailsPresenterProtocol {
    var view: StockDetailsViewProtocol? { get set }
    var quote: Quote? { get }
    var intradayData: [IntradayModel]? { get }
    var service: StocksServiceProtocol { get }
    
    func fetchIntradayData(for symbols: [String], interval: Constants.DateInterval)
}

extension StockDetailsPresenterProtocol {
    func fetchIntradayData(for symbols: [String], interval: Constants.DateInterval = .day) {
        fetchIntradayData(for: symbols, interval: interval)
    }
}

class StockDetailsPresenter: StockDetailsPresenterProtocol {
    weak var view: StockDetailsViewProtocol?
    
    internal var service: StocksServiceProtocol
    private(set) var quote: Quote?
    var intradayData: [IntradayModel]?
    
    init(service: StocksServiceProtocol, quote: Quote) {
        self.service = service
        self.quote = quote
    }
    
    func fetchIntradayData(for symbols: [String],
                           interval: Constants.DateInterval = .day) {
        service.fetchIntradayData(symbols: symbols, interval: interval) { [weak self] result in
            switch result {
            case .success(let data):
                self?.intradayData = data
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView()
                debugPrint(error.localizedDescription)
            }
        }
    }
}
