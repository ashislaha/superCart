//
//  Product.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 24/03/19.
//  Copyright © 2019 Nirupama Abraham. All rights reserved.
//

import Foundation

// MARK:- Product
class Product {
    let id: String
    let imageUrl: String
    let productName: String
    let price: String
    let brand: String
    var quantity: Int
    var isPreselected: Bool
    
    init(dict: [String: Any]) {
        id = dict[Constants.Product.id] as? String ?? ""
        imageUrl = dict[Constants.Product.imageUrl] as? String ?? ""
        productName = dict[Constants.Product.productName] as? String ?? ""
        price = dict[Constants.Product.price] as? String ?? ""
        brand = dict[Constants.Product.brand] as? String ?? ""
        quantity = dict[Constants.Product.quantity] as? Int ?? 0
        isPreselected = dict[Constants.Product.preselected] as? Bool ?? false
    }
}
