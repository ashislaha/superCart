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
        label.textColor = UIColor(red: 0, green: 76/255, blue: 148/255, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(red: 0, green: 76/255, blue: 148/255, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Place Order", for: .normal)
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        button.backgroundColor = UIColor(red: 0, green: 76/255, blue: 148/255, alpha: 1.0)
        return button
    }()

    public weak var delegate: AddToCartProtocol?
    public var quantity: Int = 0 {
        didSet {
            let message = quantity == 1 ? "Article in cart" : "Articles in cart"
            quantityLabel.text = "\(quantity)"
            messageLabel.text = message
            addToCartButton.isEnabled = quantity > 0
        }
    }

    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func layoutSetUp() {
        
        [quantityLabel, messageLabel, addToCartButton].forEach { addSubview($0) }
        
        quantityLabel.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: messageLabel.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 0))
        quantityLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true

        messageLabel.anchors(top: quantityLabel.topAnchor, bottom: quantityLabel.bottomAnchor, trailing: addToCartButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 56), size: .init(width: 60, height: 0))
        
        
        addToCartButton.anchors(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 16))
        
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        
    }
    
    @objc private func addToCartTapped() {
        delegate?.addToCart()
    }
}
