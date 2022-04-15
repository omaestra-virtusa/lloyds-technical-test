//
//  DateIntervalsCollectionView.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import UIKit

protocol DateIntervalsCollectionViewDelegate: AnyObject {
    func didSelectOption(at indexPath: IndexPath)
}

class DateIntervalsCollectionView: UIView, NibLoadableView {
    var delegate: DateIntervalsCollectionViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 40)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: self.frame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        initCollectionView()
    }
    
    private func initCollectionView() {
        collectionView.fixedLayout(in: self)
        let nib = UINib(nibName: DateIntervalsCollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DateIntervalsCollectionViewCell.reuseIdentifier)
    }
}

extension DateIntervalsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.dateIntervals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateIntervalsCollectionViewCell.reuseIdentifier, for: indexPath) as? DateIntervalsCollectionViewCell else {
            fatalError("[FATAL] Could not dequeue DateIntervalsCollectionViewCell")
        }
        
        let value = Constants.dateIntervals[indexPath.row]
        cell.valueLabel.text = value.rawValue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectOption(at: indexPath)
    }
}
