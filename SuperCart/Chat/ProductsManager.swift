//
//  ProductsManager.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/25/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

struct BasicProduct {
    let title: String
    let category: String
    let subCategory: String
}

enum ProductCategory: String {
    case dairy
    case oil
    case rice
    case sugar
    case biscuits
    case juice
    case masala
    case tea
    case coffee
    case noodles
}

class ProductsManager {
    
    static let shared = ProductsManager()
    
    var shoppingList: [ProductCategory: [BasicProduct]] = [
        .dairy: [],
        .oil: [],
        .rice: [],
        .sugar: [],
        .biscuits: [],
        .juice: [],
        .masala: [],
        .tea: [],
        .coffee: [],
        .noodles: []
    ]
    
    func getProductListForSearchAPI() -> [[String: String]] {
        guard !shoppingList.isEmpty else { return [] }
        
        var productList: [[String: String]] = []
        for (_, value) in shoppingList {
            for each in value {
                productList.append(["category": each.category, "subCategory": each.subCategory ])
            }
        }
        return productList
    }
}

