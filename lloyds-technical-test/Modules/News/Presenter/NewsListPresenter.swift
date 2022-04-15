//
//  NewsListPresenter.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation


protocol NewsListPresenterProtocol: AnyObject {
    var view: NewsListViewProtocol? { get set }
    var newsList: [News]? { get }
    var service: NewsServiceProtocol { get }
    func fetchNews()
    func numberOfSectins() -> Int
    func numberOfRowsInSection(section: Int) -> Int
}

class NewsListPresenter: NewsListPresenterProtocol {
    weak var view: NewsListViewProtocol?
    
    internal var service: NewsServiceProtocol
    var newsList: [News]?
    
    init(service: NewsServiceProtocol) {
        self.service = service
    }
    
    func fetchNews() {
        service.fetchNews() { [weak self] result in
            switch result {
            case .success(let newsList):
                self?.newsList = newsList
                self?.view?.updateView()
            case .failure(let error):
                self?.newsList = nil
//                self?.view?.displayError(title: error.code?.rawValue, description: error.message)
                debugPrint(error)
            }
        }
    }
    
    func numberOfSectins() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return newsList?.count ?? 0
    }
}
