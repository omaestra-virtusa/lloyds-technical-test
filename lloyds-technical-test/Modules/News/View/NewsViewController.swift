//
//  NewsViewController.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import UIKit

protocol NewsListViewProtocol: AnyObject {
    func updateView()
}

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: NewsListPresenterProtocol?
    
    static func create(presenter: NewsListPresenterProtocol) -> NewsViewController {
        let viewController = NewsViewController()
        viewController.presenter = presenter
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        presenter?.fetchNews()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: NewsTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.numberOfSectins() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("[FATAL] Could not dequeue NewsTableViewCell")
        }
        
        guard let news = presenter?.newsList?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setupView(for: news)
        
        return cell
    }
}

extension NewsViewController: NewsListViewProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
