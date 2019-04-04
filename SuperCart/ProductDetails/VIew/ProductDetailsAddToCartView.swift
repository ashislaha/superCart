//
//  ProductDetailsAddToCartView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 01/04/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol ProductDetailsAddToCartProtocol: class {
    func addToCart(_ quantity: Int)
}

class ProductDetailsAddToCartView: UIView {

    // add to cart button
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Cart", for: .normal)
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        button.backgroundColor = UIColor(red: 0, green: 76/255, blue: 148/255, alpha: 1.0)
        return button
    }()

    // edit quantity view
    private let editQuantityView: EditQuantityView = {
        let editQuantityView = EditQuantityView()
        editQuantityView.translatesAutoresizingMaskIntoConstraints = false
        return editQuantityView
    }()

    private var quantity = 1
    
    public weak var delegate: ProductDetailsAddToCartProtocol?
    
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func layoutSetUp() {
        
        editQuantityView.delegate = self
        editQuantityView.quantity = quantity
        
        [editQuantityView, addToCartButton].forEach { addSubview($0) }
        
        editQuantityView.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: addToCartButton.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 10), size: .init(width: 100, height: 0))
        
        
        addToCartButton.anchors(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 16))
        
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        
    }
    
    @objc private func addToCartTapped() {
        delegate?.addToCart(quantity)
    }

}

extension ProductDetailsAddToCartView: EditQuantityViewProtocol {
    func quantityUpdated(_ quantity: Int) {
        self.quantity = quantity
    }
}
