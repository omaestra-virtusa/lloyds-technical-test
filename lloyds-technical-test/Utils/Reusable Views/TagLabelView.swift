//
//  TagLabelView.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import UIKit

class TagLabelView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 8 {
       didSet {
           updateLayout()
       }
    }
    
    @IBInspectable var color: UIColor? = .systemBlue {
        didSet {
            updateLayout()
        }
    }
    
    @IBInspectable var textColor: UIColor? = .white {
        didSet {
            updateLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("TagLabelView", owner: self, options: nil)
        contentView.fixedLayout(in: self)
        self.containerView.backgroundColor = .clear
        self.backgroundColor = .clear
        updateLayout()
    }
    
    public func updateLayout() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = cornerRadius > 0
        contentView.backgroundColor = color
        valueLabel.textColor = textColor
    }
}
