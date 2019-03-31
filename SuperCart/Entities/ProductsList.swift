//
//  ProductsList.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 28/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

// MARK:- Product
class ProductsList {
    let categories: [Category]
    let missingItems: [Product]
    
    init(dict: [String: Any]) {
        if let categoriesArr = dict[Constants.Categories.categories] as? [[String: Any]] {
            var categories : [Category] = []
            for category in categoriesArr {
                let categoryObj = Category(dict: category)
                categories.append(categoryObj)
            }
            self.categories = categories
        } else {
            categories = []
        }

        if let missingItemsArr = dict[Constants.MissingItems.missingItems] as? [[String: Any]] {
            var  missingItems : [Product] = []
            for missingItem in missingItemsArr {
                let missingItemObj = Product(dict: missingItem)
                missingItems.append(missingItemObj)
            }
            self.missingItems = missingItems
        } else {
            missingItems = []
        }
    }
}
