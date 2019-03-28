//
//  ProductListViewController+Ext.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

enum ProductListViewCell {
    case productCell([Product])
    case messageCell(String)
}

struct ProductListViewSection {
    let name: String
    let cells: [ProductListViewCell]
    var isOpen: Bool
}

struct ProductListViewModel {
    var sections: [ProductListViewSection]
}

extension ProductListView {
    func getViewModel() -> ProductListViewModel? {
        guard let categories = self.categories else { return nil }
        let sections = categories.map { (category) -> ProductListViewSection in
            var cells: [ProductListViewCell] = []
            let productCell = ProductListViewCell.productCell(category.products)
            cells.append(productCell)
            for message in category.messages {
                let messageCell = ProductListViewCell.messageCell(message)
                cells.append(messageCell)
            }
            let section = ProductListViewSection(name: category.name, cells: cells, isOpen: false)
            return section
        }
        let viewModel = ProductListViewModel(sections: sections)
        return viewModel
    }
}
