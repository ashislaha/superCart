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
    let id: Int
    let imageUrl: String
    let productName: String
    let price: Float
    let brand: String
    var quantity: Int
    var isPreselected: Bool
    let category: String
    let subCategory: String
    
    init(dict: [String: Any]) {
        id = dict[Constants.Product.id] as? Int ?? 0
        imageUrl = dict[Constants.Product.imageUrl] as? String ?? ""
        productName = dict[Constants.Product.productName] as? String ?? ""
        price = dict[Constants.Product.price] as? Float ?? 0
        brand = dict[Constants.Product.brand] as? String ?? ""
        quantity = dict[Constants.Product.quantity] as? Int ?? 0
        isPreselected = dict[Constants.Product.preselected] as? Bool ?? false
        category = dict[Constants.Product.category] as? String ?? ""
        subCategory = dict[Constants.Product.subCategory] as? String ?? ""
    }
    
    func getOrderParams() -> [String: Any] {
        let params: [String: Any] = [
        "id": id,
        "quantity": quantity,
        "category": category,
        "subCategory": subCategory
        ]
        return params
    }
}
