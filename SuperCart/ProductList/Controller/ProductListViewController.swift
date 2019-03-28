//
//  ProductListViewController.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    public var productList: [[String: String]] = [] {
        didSet {
            self.fetchProductList()
        }
    }
    
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
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()


    let dataSourceProvider = DataServiceProvider()
    var categories: [Category] = [] {
        didSet {
            self.productListView.categories = categories
            let selectedProducts: [Product] = categories.flatMap { (category) -> [Product] in
                return category.products.filter({ (product) -> Bool in
                    return product.isPreselected
                })
            }
            self.selectedProducts = selectedProducts
        }
    }
    
    var selectedProducts: [Product]  = [] {
        didSet {
            addToCartView.quantity = selectedProducts.count
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Product List"
        layoutSetUp()
    }
    
    private func layoutSetUp() {
        
        [productListView, addToCartView, activityIndicator].forEach { view.addSubview($0) }
        productListView.delegate = self
        addToCartView.delegate = self
        
        productListView.anchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: addToCartView.topAnchor, trailing: view.trailingAnchor)
        addToCartView.anchors(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        addToCartView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        activityIndicator.anchors(centerX: view.centerXAnchor, centerY: view.centerYAnchor)

    }
    
    private func fetchProductList() {
        activityIndicator.startAnimating()
        try? dataSourceProvider.getProductsList(products: self.productList) {[weak self] (categories) in
            self?.activityIndicator.stopAnimating()
            self?.categories = categories
        }
    }
}

//MARK:- ProductListProtocol
extension ProductListViewController: ProductListProtocol {
    func itemSelected(model: Product) {
        selectedProducts.append(model)
    }
    
    func itemRemoved(model: Product) {
        selectedProducts = selectedProducts.filter({ (product) -> Bool in
            return product.id != model.id
        })
    }
}

//MARK:- AddToCartProtocol
extension ProductListViewController: AddToCartProtocol {
    func addToCart() {
        print(selectedProducts)
    }
}
