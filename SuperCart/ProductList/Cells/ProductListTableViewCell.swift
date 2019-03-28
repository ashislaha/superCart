//
//  ProductListTableViewCell.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 27/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol ProductListTableViewCellProtocol: class {
    func itemAdded(_ product: Product)
    func itemRemoved(_ product: Product)
}

class ProductListTableViewCell: UITableViewCell {

    // private properties
    private let cellId = "ProductViewCellID"
    private var collectionView: UICollectionView!
    
    var model: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: ProductListTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionViewSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setUpCell() {
        collectionViewSetUp()
        contentView.backgroundColor = .white
    }
    
    // MARK:- setup collectionView
    private func collectionViewSetUp() {
        let layout =  UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal 
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .white
        backgroundColor = .white
    }
    
    override func prepareForReuse() {
        model = []
        collectionView.removeFromSuperview()
    }
}

//MARK:- UICollectionViewDataSource
extension ProductListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < model.count,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        let product = model[indexPath.row]
        cell.model = product
        cell.delegate = self
        return cell
    }
}

//MARK:- UICollectionViewDelegate
extension ProductListTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < model.count else { return }
        let product = model[indexPath.row]
//        product.isPreselected = !product.isPreselected
        if product.isPreselected {
            delegate?.itemRemoved(product)
        } else {
            delegate?.itemAdded(product)
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ProductListTableViewCell: UICollectionViewDelegateFlowLayout {
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: frame.width/2 - 16, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

//MARK:- ProductCollectionViewCellProtocol
extension ProductListTableViewCell: ProductCollectionViewCellProtocol {
    func itemAdded(_ product: Product) {
        delegate?.itemAdded(product)
    }
    
    func itemRemoved(_ product: Product) {
        delegate?.itemRemoved(product)
    }
}
