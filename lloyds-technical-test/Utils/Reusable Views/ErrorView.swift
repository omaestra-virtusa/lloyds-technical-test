//
//  ErrorView.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import UIKit

class ErrorView: UIView, NibLoadableView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        contentView.fixedLayout(in: self)
    }
    
    func setupView(title: String, message: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = message
    }
}
