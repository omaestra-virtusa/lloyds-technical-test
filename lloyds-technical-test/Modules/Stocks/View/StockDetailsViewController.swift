//
//  StockDetailsViewController.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 14/04/2022.
//

import UIKit
import DSFSparkline

protocol StockDetailsViewProtocol: AnyObject {
    func updateView()
}

class StockDetailsViewController: UIViewController {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var priceValueLabel: UILabel!
    @IBOutlet weak private var dayChangeValueLabel: UILabel!
    @IBOutlet weak private var currencyValueLabel: UILabel!
    @IBOutlet weak private var dateIntervalCollectionView: DateIntervalsCollectionView! {
        didSet {
            dateIntervalCollectionView.delegate = self
        }
    }
    @IBOutlet weak var chartViewContainer: UIView!
    @IBOutlet weak private var openValueLabel: UILabel!
    @IBOutlet weak private var highValueLabel: UILabel!
    @IBOutlet weak private var lowValueLabel: UILabel!
    @IBOutlet weak private var volumeValueLabel: UILabel!
    @IBOutlet weak private var peValueLabel: UILabel!
    @IBOutlet weak private var marketCapValueLabel: UILabel!
    @IBOutlet weak private var weekHighValueLabel: UILabel!
    @IBOutlet weak private var weekLowValueLabel: UILabel!
    @IBOutlet weak private var averageVolumeValueLabel: UILabel!
    
    lazy var chartView: DSFSparklineLineGraphView = {
        let chartView = DSFSparklineLineGraphView()
        chartView.graphColor = UIColor.systemIndigo
        chartView.showZeroLine = true
        
        return chartView
    }()
    
    var presenter: StockDetailsPresenterProtocol?
    weak private var navigator: StocksListNavigator?
    
    static func create(quote: Quote,
                       navigator: StocksListNavigator,
                       service: StocksServiceProtocol) -> StockDetailsViewController {
        let controller = StockDetailsViewController()
        let presenter =   StockDetailsPresenter(service: service, quote: quote)
        presenter.view = controller
        controller.presenter = presenter
        controller.navigator = navigator
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        self.showSpinner(onView: chartViewContainer)
        presenter?.fetchIntradayData(for: [presenter?.quote?.ticker ?? ""], interval: .day)
        updateView()
    }

    private func setupCollectionView() {
        dateIntervalCollectionView.collectionView.allowsMultipleSelection = false
        dateIntervalCollectionView.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }

    private func setupView(for quote: Quote) {
        titleLabel.text = quote.ticker
        nameLabel.text = quote.name
        priceValueLabel.text = quote.price.description
        dayChangeValueLabel.text = quote.dayChange.description
        currencyValueLabel.text = quote.currency
        openValueLabel.text = quote.dayOpen.description
        highValueLabel.text = quote.dayHigh.description
        lowValueLabel.text = quote.dayLow.description
        volumeValueLabel.text = quote.volume.description
        peValueLabel.text = quote.previousClosePrice.description
        marketCapValueLabel.text = quote.marketCap.description
        weekHighValueLabel.text = quote.weekHigh.description
        weekLowValueLabel.text = quote.weekLow.description
        averageVolumeValueLabel.text = "-"
    }
    
    private func setupChart() {
        if let intradayData = presenter?.intradayData {
            let data: [CGFloat] = intradayData.compactMap({
                CGFloat($0.data.close)
            })

            if !data.isEmpty {
                chartView.fixedLayout(in: self.chartViewContainer)

                let sparklineDataSource = DSFSparkline.DataSource(windowSize: 30, range: nil, zeroLineValue: 0)
                chartView.dataSource = sparklineDataSource

                DispatchQueue.main.async {
                    sparklineDataSource.set(values: data)
                }
            }
        }
    }
}

extension StockDetailsViewController: StockDetailsViewProtocol {
    func updateView() {
        self.removeSpinner()
        guard let quote = presenter?.quote else {
            return
        }
        
        setupView(for: quote)
        setupChart()
    }
}

extension StockDetailsViewController: DateIntervalsCollectionViewDelegate {
    func didSelectOption(at indexPath: IndexPath) {
        let interval = Constants.dateIntervals[indexPath.row]
        if let quote = presenter?.quote {
            self.showSpinner(onView: chartViewContainer)
            presenter?.fetchIntradayData(for: [quote.ticker],
                                            interval: interval)
        }
    }
}
