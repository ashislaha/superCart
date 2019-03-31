//
//  Category.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 24/03/19.
//  Copyright © 2019 Nirupama Abraham. All rights reserved.
//

import Foundation

// MARK:- Record
class Category {
    let name: String
    let products: [Product]
    let messages: [String]

    init(dict: [String: Any]) {
        name = dict[Constants.Category.name] as? String ?? ""
        if let productsArr = dict[Constants.Category.products] as? [[String: Any]] {
            var  products : [Product] = []
            for product in productsArr {
                let productObj = Product(dict: product)
                products.append(productObj)
            }
            self.products = products
        } else {
            products = []
        }
        if let promotions = dict[Constants.Category.promotions] as? [String: String], let message = promotions[Constants.Category.message] {
            messages = [message]
        } else {
            messages = []
        }
    }
}
