//
//  Category.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 24/03/19.
//  Copyright © 2019 Nirupama Abraham. All rights reserved.
//

import Foundation

// MARK:- Record
struct Category {
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
        messages = dict[Constants.Category.messages] as? [String] ?? []
    }
}
