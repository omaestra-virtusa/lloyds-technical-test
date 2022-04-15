//
//  DateIntervalsCollectionViewCell.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import UIKit

class DateIntervalsCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    
    lazy var customBackgroundView: UIView = {
        let view = UIView(frame: bounds)
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    lazy var selectedView: UIView = {
        let view = UIView(frame: bounds)
        view.backgroundColor = UIColor.systemIndigo
        view.layer.cornerRadius = 5.0
        
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.backgroundColor = .clear
        self.backgroundView = customBackgroundView
        self.selectedBackgroundView = selectedView
    }
    
    private func updateView() {
        self.valueLabel.textColor = self.isSelected ? .white : .systemIndigo
    }
    
    func setupValue(_ value: String) {
        self.valueLabel.text = value
    }
}
