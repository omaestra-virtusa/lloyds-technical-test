//
//  NewsTableViewCell.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var articleImageView: UIImageView!
    @IBOutlet weak private var footerLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 6.0
        articleImageView.layer.masksToBounds = true
        articleImageView.layer.cornerRadius = 6.0
    }
    
    func setupView(for news: News) {
        titleLabel.text = news.title
        authorLabel.text = news.source
        dateLabel.text = dateFormatter.date(from: news.publishedAt)?.formatted(date: .abbreviated, time: .omitted)
        articleImageView.kf.setImage(with: URL(string: news.imageUrl), placeholder: nil)
        footerLabel.text = news.keywords
    }
}
