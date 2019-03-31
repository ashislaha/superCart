//
//  ProductDetailsSectionHeaderView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 31/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductDetailsSectionHeaderView: UITableViewHeaderFooterView {
    
    // price
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    // public properties
    public var model: ProductDetailsViewSection? {
        didSet {
            titleLabel.text = model?.name
        }
    }
    
    // MARK:- init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func layoutSetUp() {
        
        self.contentView.backgroundColor = .white
        
        addSubview(titleLabel)
        
        titleLabel.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        
    }
}
