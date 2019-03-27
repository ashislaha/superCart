//
//  ProductListViewController.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    public var productListParams: [String: Any] = [:]
    
    // product list view
    private let productListView: ProductListView = {
        let productListView = ProductListView()
        productListView.translatesAutoresizingMaskIntoConstraints = false
        return productListView
    }()
    
    let dataSourceProvider = DataServiceProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Product List"
        layoutSetUp()
    }
    
    private func layoutSetUp() {
        view.addSubview(productListView)
        productListView.delegate = self
        productListView.anchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}

//MARK:- ProductListProtocol
extension ProductListViewController: ProductListProtocol {
    func itemSelected(model: Product, index: Int) {
        
    }
}
