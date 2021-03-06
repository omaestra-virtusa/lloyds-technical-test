//
//  StocksTableViewController.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import UIKit
import DSFSparkline

protocol StocksViewProtocol: AnyObject {
    var navigator: StocksListNavigator? { get set }
    
    func updateView()
    func displayError(title: String?, description: String?)
}

class StocksTableViewController: UITableViewController {
    var presenter: StocksListPresenterProtocol?
    var navigator: StocksListNavigator?
        
    static func create() -> StocksTableViewController {
        let controller = StocksTableViewController()
        let presenter = StocksListPresenter(service: StocksService(network: AlamofireNetworking()))
        presenter.view = controller
        controller.presenter = presenter
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupRefreshControl()
        
        presenter?.fetchQuotes(for: Constants.initialSymbols)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(newsButtonTapped))
        self.title = "Stocks"
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: StockQuoteTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: StockQuoteTableViewCell.reuseIdentifier)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = .clear
        refreshControl?.tintColor = .systemIndigo
        refreshControl?.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSectins() ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockQuoteTableViewCell.reuseIdentifier, for: indexPath) as! StockQuoteTableViewCell

        guard let quote = self.presenter?.getQuote(at: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setupView(for: quote)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let quote = presenter?.getQuote(at: indexPath) else {
            return
        }
        self.navigator?.navigate(to: .quoteDetails(quote: quote), navigationType: .overlay)
    }
    
    @objc func newsButtonTapped(_ sender: Any) {
        navigator?.navigateToNews()
    }
    
    @objc func didPullToRefresh(_ sender: Any) {
        self.refreshControl?.beginRefreshing()
        presenter?.fetchQuotes(for: Constants.initialSymbols)
    }
}

extension StocksTableViewController: StocksViewProtocol {
    func updateView() {
        self.refreshControl?.endRefreshing()
        self.tableView.backgroundView = nil
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError(title: String?, description: String?) {
        self.refreshControl?.endRefreshing()
        let errorView = ErrorView(frame: self.tableView.frame)
        errorView.setupView(title: title ?? "", message: description ?? "")
        self.tableView.backgroundView = errorView
    }
}
