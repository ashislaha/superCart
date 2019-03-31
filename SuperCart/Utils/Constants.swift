//
//  Constants.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 24/03/19.
//  Copyright © 2019 Nirupama Abraham. All rights reserved.
//

import UIKit

struct Constants {
    static let pinkColor = UIColor(red: 255.0/255.0, green: 90.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    struct CountryPage {
        static let baby = "baby"
        static let pink = "pink"
        static let countriesDict: [String: [String]] = [
            "India": ["Kolkata", "Delhi", "Mumbai", "Bangalore", "Chennai"],
            "USA": ["New York City", "Chicogo", "Washington D.C.", "Los Angeles", "Seattle", "Boston", "San Francisco"],
            "Canada": ["Toronto", "Montreal", "Ottawa", "Calgary", "Vancouver"]
        ]
        static let countries = ["India", "USA", "Canada"]
        static let countryInfo = "Select Country"
        static let cityInfo = "Select City"
    }
    struct DropDown {
        static let dropDownCell = "dropDownCell"
        static let dropDownHeader = "dropDownHeader"
    }
    struct HomePage {
        static let backGroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        static let categories = "Categories"
        struct ProductListView {
            static let productCell = "productCell"
        }
        static let selectCategory = "Select Category"
    }
    struct Cart {
        static let cartKey = "cartKey"
    }
    struct DataService {
        static let endPoint = "https://explore-world.herokuapp.com"
        static let defaultProductsEndPoint = "http://static-data.surge.sh/products/products.101.json" // Baby-Boy
        
    }
    struct Categories {
        static let categories = "categories"
    }
    struct Category {
        static let name = "name"
        static let products = "products"
        static let messages = "messages"
    }
    struct Attributes {
        static let brand = "Brand"
        static let skuUnitOfMeasure = "sku.unit_of_measure"
        static let records = "records"
    }
    struct Product {
        static let id = "id"
        static let imageUrl = "image_url"
        static let productName = "name"
        static let price = "price"
        static let brand = "brand"
        static let quantity = "quantity"
        static let preselected = "preselected"
        static let category = "category"
        static let subCategory = "subcategory"
        static let productDetails = "productDetails"
    }
    struct MissingItems {
        static let missingItems = "missingItems"
        static let missingItemsHeader = "Missing Items"
    }
    
    struct BoughtTogetherItems {
        static let boughtTogetherItems = "bought_together"
        static let boughtTogetherItemsHeader = "Related Items"
    }
    struct SimilarItems {
        static let similarItems = "similar_products"
        static let similarItemsHeader = "Suggested Items"
    }
}

enum RespondingDropDown {
    case country
    case city
    case none
}
