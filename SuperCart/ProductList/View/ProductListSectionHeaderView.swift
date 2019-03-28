//
//  ProductListSectionHeaderView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 28/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol ProductListSectionHeaderViewProtocol: class {
    func reloadSection(_ section: Int, isOpen: Bool)
}

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
    
    private let showOrHideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icon_more"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // public properties
    public var section: Int?
    public weak var delegate: ProductListSectionHeaderViewProtocol?
    public var model: ProductListViewSection? {
        didSet {
            titleLabel.text = model?.name
            let image = (model?.isOpen ?? false) ? #imageLiteral(resourceName: "icon_less") : #imageLiteral(resourceName: "icon_more")
            showOrHideButton.setImage(image, for: .normal)
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
        
        [titleLabel, showOrHideButton].forEach { addSubview($0) }
        
        titleLabel.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: showOrHideButton.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        showOrHideButton.anchors(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 16), size: .init(width: 16, height: 0))
        
        
        showOrHideButton.addTarget(self, action: #selector(showOrHideButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func showOrHideButtonTapped() {
        guard let section = section else { return }
        delegate?.reloadSection(section, isOpen: !(model?.isOpen ?? false))
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
