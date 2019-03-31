//
//  ProductDetailsView+Ext.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 31/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

enum ProductDetailsViewCell {
    case productsDetailsCell(Product)
    case productListCell([Product])
}

struct ProductDetailsViewSection {
    let name: String
    let cells: [ProductDetailsViewCell]
}

struct ProductDetailsViewModel {
    var sections: [ProductDetailsViewSection]
}

extension ProductDetailsView {
    func getViewModel() -> ProductDetailsViewModel? {
        guard let productDetails = self.productDetails else { return nil }
        var sections: [ProductDetailsViewSection] = []
        if let productDict = productDetails[Constants.Product.productDetails] as? [String: Any] {
            let product = Product(dict: productDict)
            let productCell = ProductDetailsViewCell.productsDetailsCell(product)
            let section = ProductDetailsViewSection(name: Constants.Category.products, cells: [productCell])
            sections.append(section)
        }
        if let suggestedItemsArr = productDetails[Constants.SimilarItems.similarItems] as? [[String: Any]] {
            var  suggestedItems : [Product] = []
            for product in suggestedItemsArr {
                let productObj = Product(dict: product)
                suggestedItems.append(productObj)
            }
            let productCell = ProductDetailsViewCell.productListCell(suggestedItems)
            let section = ProductDetailsViewSection(name: Constants.SimilarItems.similarItemsHeader, cells: [productCell])
            sections.append(section)
        }
        if let relatedItemsArr = productDetails[Constants.BoughtTogetherItems.boughtTogetherItems] as? [[String: Any]] {
            var  relatedItems : [Product] = []
            for product in relatedItemsArr {
                let productObj = Product(dict: product)
                relatedItems.append(productObj)
            }
            let productCell = ProductDetailsViewCell.productListCell(relatedItems)
            let section = ProductDetailsViewSection(name: Constants.BoughtTogetherItems.boughtTogetherItemsHeader, cells: [productCell])
            sections.append(section)
        }
        let viewModel = ProductDetailsViewModel(sections: sections)
        return viewModel
    }
}
