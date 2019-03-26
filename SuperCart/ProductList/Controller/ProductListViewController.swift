//
//  ProductListViewController.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    public var productList: [[String: String]] = []
    
    // product list view
    private let productListView: ProductListView = {
        let productListView = ProductListView()
        productListView.translatesAutoresizingMaskIntoConstraints = false
        return productListView
    }()
    
    // add to cart view
    private let addToCartView: AddToCartView = {
        let addToCartView = AddToCartView()
        addToCartView.translatesAutoresizingMaskIntoConstraints = false
        return addToCartView
    }()

    let dataSourceProvider = DataServiceProvider()
    var selectedProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Product List"
        layoutSetUp()
    }
    
    private func layoutSetUp() {
        view.addSubview(productListView)
        productListView.delegate = self
        addToCartView.delegate = self
        
        productListView.anchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: addToCartView.topAnchor, trailing: view.trailingAnchor)
        addToCartView.anchors(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        addToCartView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}

//MARK:- ProductListProtocol
extension ProductListViewController: ProductListProtocol {
    func itemSelected(model: Product, index: Int) {
        
    }
    
    func itemRemoved(model: Product, index: Int) {
        
    }
}

//MARK:- AddToCartProtocol
extension ProductListViewController: AddToCartProtocol {
    func addToCart() {
        
    }
}
