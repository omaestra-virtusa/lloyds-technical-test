//
//  StocksTableViewController.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import UIKit

protocol StocksViewProtocol: AnyObject {
    func updateView()
    func displayError()
}

class StocksTableViewController: UITableViewController {
    var presenter: StocksListPresenterProtocol?
    weak var navigator: StocksListNavigator?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        presenter?.fetchQuotes(for: ["AAPL", "TSLA", "MSFT"])
    }
    
    static func create() -> StocksTableViewController {
        let controller = StocksTableViewController()
        let presenter = StocksListPresenter(service: StocksService(network: AlamofireNetworking()))
        presenter.view = controller
        controller.presenter = presenter
        
        return controller
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: StockQuoteTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: StockQuoteTableViewCell.reuseIdentifier)
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
        navigator?.navigate(to: .quoteDetails(quote: quote), navigationType: .overlay)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension StocksTableViewController: StocksViewProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError() {
        // TODO: Display Error
    }
}
