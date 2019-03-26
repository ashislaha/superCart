//
//  AddToCartView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 26/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol AddToCartProtocol: class {
    func addToCart()
}

class AddToCartView: UIView {

    private let quantityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .green
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.accessibilityIdentifier = ""
        return label
    }()

    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "header_close"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()

    weak var delegate: AddToCartProtocol?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layoutSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func layoutSetUp() {
        
        [quantityLabel, messageLabel, addToCartButton].forEach { addSubview($0) }
        
        quantityLabel.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: messageLabel.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 0))
        quantityLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true

        messageLabel.anchors(top: quantityLabel.topAnchor, bottom: quantityLabel.bottomAnchor, trailing: addToCartButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 30))
        
        
        addToCartButton.anchors(top: quantityLabel.bottomAnchor, bottom: quantityLabel.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 35, left: 26, bottom: 0, right: 16))
        
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        
    }
    
    @objc private func addToCartTapped() {
        delegate?.addToCart()
    }
}
