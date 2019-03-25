//
//  ProductsManager.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/25/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

struct AddedProduct {
    let prodName: String
    let category: String
    let image: UIImage
}

enum ProductCategory: String {
    case milks
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
    
    var shoppingList: [ProductCategory: [AddedProduct]] = [
        .milks: [],
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
}

