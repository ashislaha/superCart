//
//  AppManager.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/25/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

struct BasicProduct: Equatable {
    let title: String
    let category: String
    let subCategory: String
    
    public static func == (lhs: BasicProduct, rhs: BasicProduct) -> Bool {
        return lhs.title.lowercased() == rhs.title.lowercased() &&
            lhs.category.lowercased() == rhs.category.lowercased() &&
            lhs.subCategory.lowercased() == rhs.subCategory.lowercased()
    }
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
    case dal
    
    func image() -> UIImage {
        switch self {
        case .dairy: return #imageLiteral(resourceName: "dairy")
        case .oil: return #imageLiteral(resourceName: "oil")
        case .rice: return #imageLiteral(resourceName: "rice")
        case .sugar: return #imageLiteral(resourceName: "sugar")
        case .biscuits: return #imageLiteral(resourceName: "biscuits")
        case .juice: return #imageLiteral(resourceName: "juice")
        case .masala: return #imageLiteral(resourceName: "masala")
        case .tea: return #imageLiteral(resourceName: "tea")
        case .coffee: return #imageLiteral(resourceName: "coffee")
        case .noodles: return #imageLiteral(resourceName: "noodles")
        case .dal: return #imageLiteral(resourceName: "dal")
        }
    }
}

class AppManager {
    
    static let shared = AppManager()
    public var username: String?
    public var userAgent: [String: String] = [:]
    public var products: [Product] = []
    
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
        .noodles: [],
        .dal: []
    ]
    
    func getProductListForSearchAPI() -> [String: Any] {
        guard !shoppingList.isEmpty else { return [:] }
        
        var productList: [[String: String]] = []
        for (_, value) in shoppingList {
            var category = ""
            var subCategory = ""
            for each in value {
                category = each.category
                subCategory += each.subCategory + ","
            }
            if !category.isEmpty {
                subCategory.removeLast() // remove last ","
                productList.append(["cat": category, "subCat": subCategory ])
            }
        }
        return [
            "id": username ?? "",
            "items": productList
        ]
    }
    
    public func clearList() {
        shoppingList = [
            .dairy: [],
            .oil: [],
            .rice: [],
            .sugar: [],
            .biscuits: [],
            .juice: [],
            .masala: [],
            .tea: [],
            .coffee: [],
            .noodles: [],
            .dal: []
        ]
    }
    
    public func addProductToCart(_ productId: Int,_ quantity: Int) {
        if let product = (self.products.filter { (product) -> Bool in
            return product.id == productId
            }).first {
            product.quantity = quantity
            product.isPreselected = true
        }
    }
}

