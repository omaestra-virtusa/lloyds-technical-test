//
//  StockQuoteTableViewCell.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import UIKit
import DSFSparkline

class StockQuoteTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var dayChangeTagView: TagLabelView!
    @IBOutlet weak var chartView: DSFSparklineLineGraphView!
    
    var quote: Quote?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        chartView.graphColor = UIColor.systemBlue
        chartView.showZeroLine = true
        chartView.lineWidth = 0.3
        chartView.backgroundColor = .clear
        chartView.showsLargeContentViewer = false
    }
    
    func setupView(for quote: Quote) {
        titleLabel.text = quote.ticker
        subtitleLabel.text = quote.name
        priceValueLabel.text = "\(quote.currency) \(quote.price.description)"
        
        let operatorString = quote.dayChange > 0 ? "" : ""
        dayChangeTagView.valueLabel.text = "\(operatorString)\(quote.dayChange.description)"
        dayChangeTagView.color = quote.dayChange > 0 ? .systemGreen : .systemRed
        dayChangeTagView.valueLabel.textAlignment = .right
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
