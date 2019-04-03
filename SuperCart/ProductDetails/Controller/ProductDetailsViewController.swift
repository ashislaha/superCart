//
//  ProductDetailsViewController.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 24/03/19.
//  Copyright © 2019 Nirupama Abraham. All rights reserved.
//

import UIKit

protocol ProductDetailsProtocol: class {
    func favouriteSelected(selection: Bool, index: Int)
}

class ProductDetailsViewController: UIViewController {
    
    // product list view
    private let productDetailsView: ProductDetailsView = {
        let productDetailsView = ProductDetailsView()
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        return productDetailsView
    }()
    
    // add to cart view
    private let addToCartView: ProductDetailsAddToCartView = {
        let addToCartView = ProductDetailsAddToCartView()
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
    
    var model: Product? {
        didSet {
            guard let productId = model?.id else {
                return
            }
            fetchProductDetails(productId: "\(productId)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Product Details"
        layoutSetUp()
    }
    
    private func layoutSetUp() {
        
        [productDetailsView, addToCartView, activityIndicator].forEach { view.addSubview($0) }
        addToCartView.delegate = self
        productDetailsView.delegate = self
        
        productDetailsView.anchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: addToCartView.topAnchor, trailing: view.trailingAnchor)
        addToCartView.anchors(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        addToCartView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        activityIndicator.anchors(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        
    }

    private func fetchProductDetails(productId: String) {
        activityIndicator.startAnimating()
        try? dataSourceProvider.getProductDetails(productId: productId) {[weak self] (product) in
            self?.activityIndicator.stopAnimating()
            self?.productDetailsView.productDetails = product
        }
    }

}

//MARK:- AddToCartProtocol
extension ProductDetailsViewController: ProductDetailsAddToCartProtocol {
    func addToCart(_ quantity: Int) {
        guard let product = model else { return }
        AppManager.shared.addProductToCart(product.id, quantity)
        let message = "Item added successfully"
        let alertVC = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

//MARK:- ProductDetailsViewProtocol
extension ProductDetailsViewController: ProductDetailsViewProtocol {
    func viewProductDetails(_ product: Product) {
        let productDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.model = product
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
}
