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
        .noodles: []
    ]
    
    func getProductListForSearchAPI() -> [String: Any] {
        guard !shoppingList.isEmpty else { return [:] }
        
        var productList: [[String: String]] = []
        for (_, value) in shoppingList {
            for each in value {
                productList.append(["cat": each.category, "subCat": each.subCategory ])
            }
        }
        return [
            "id": username ?? "",
            "items": productList
        ]
    }
}

