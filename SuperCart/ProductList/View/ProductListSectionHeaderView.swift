//
//  ProductListSectionHeaderView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 28/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductListSectionHeaderView: UITableViewHeaderFooterView {

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
    
    // imageview
    private let showOrHideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "placeholder")
        return imageView
    }()
    
    
    // public properties
    public var section: Int?
//    public weak var delegate: ProductListSectionHeaderViewProtocol?
    public var model: ProductListViewSection? {
        didSet {
            titleLabel.text = model?.name
            let image = (model?.isOpen ?? false) ? #imageLiteral(resourceName: "icon_less") : #imageLiteral(resourceName: "icon_more")
            showOrHideImageView.image = image
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
        
        [titleLabel, showOrHideImageView].forEach { addSubview($0) }
        
        titleLabel.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: showOrHideImageView.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        showOrHideImageView.anchors(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 16), size: .init(width: 16, height: 0))
        
    }
}
