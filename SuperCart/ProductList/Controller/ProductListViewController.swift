//
//  ProductListViewController.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    // product list view
    private let productListView: ProductListView = {
        let productListView = ProductListView()
        productListView.translatesAutoresizingMaskIntoConstraints = false
        return productListView
    }()
    
    let dataSourceProvider = DataServiceProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        layoutSetUp()
    }
    
    private func layoutSetUp() {
        view.addSubview(productListView)
        productListView.delegate = self
        
        productListView.anchors(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- ProductListProtocol
extension ProductListViewController: ProductListProtocol {
    func itemSelected(model: Product, index: Int) {
        
    }
}
