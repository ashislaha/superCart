//
//  ProductListViewController.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    public var productListParams: [String: Any] = [:] {
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
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()


    let dataSourceProvider = DataServiceProvider()
    var productsList: ProductsList? {
        didSet {
            self.productListView.productsList = productsList
            let selectedProducts: [Product] = productsList?.categories.flatMap { (category) -> [Product] in
                return category.products.filter({ (product) -> Bool in
                    return product.isPreselected
                })
            } ?? []
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
        try? dataSourceProvider.getProductsList(productsList: self.productListParams) {[weak self] (productsList) in
            self?.activityIndicator.stopAnimating()
            self?.productsList = productsList
        }
    }
    
    private func placeOrder() {
        var items: [[String: Any]] = [[:]]
        for product in selectedProducts {
            let item: [String: Any] = [
                "id": product.id,
                "cat": product.category,
                "subCat": product.subCategory,
                "quantity": product.quantity
            ]
            items.append(item)
        }
        try? dataSourceProvider.placeOrder(products: items) {[weak self] (productsList) in
            self?.activityIndicator.stopAnimating()
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
    
    func viewProductDetails(_ product: Product) {
        let productDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.model = product
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
}

//MARK:- AddToCartProtocol
extension ProductListViewController: AddToCartProtocol {
    func addToCart() {
        activityIndicator.startAnimating()
        let productParams: [[String: Any]] = self.selectedProducts.map { (product) -> [String: Any] in
            return product.getOrderParams()
        }
        try? dataSourceProvider.placeOrder(products: productParams) {[weak self] (success) in
            self?.activityIndicator.stopAnimating()
        }
    }
}
