//
//  ProductDetailsView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 30/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductDetailsView: UIView {

    // private properties
    private let productCellId = "productCellID"
    private let relatedItemsCellId = "relatedItemsCellID"
    private let suggestedItemsCellId = "suggestedItemsCellID"
    private let headerViewId = "headerViewID"
    private var tableView: UITableView!
    private var model: ProductDetailsViewModel?

    public var productDetails: [String: Any]?{
        didSet {
            let viewModel = self.getViewModel()
            self.model = viewModel
            tableView.reloadData()
        }
    }
    
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableViewSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func tableViewSetUp() {
        tableView = UITableView(frame: bounds, style: .grouped)
        addSubview(tableView)
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductDetailsTableViewCell.self, forCellReuseIdentifier: productCellId)
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: relatedItemsCellId)
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: suggestedItemsCellId)
        tableView.register(ProductListSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: headerViewId)
        tableView.allowsSelection = true
//        tableView.estimatedRowHeight = 400
        backgroundColor = .white
    }
}

//MARK:- UITableViewDataSource
extension ProductDetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = model?.sections[section] else { return 0 }
        return section.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = model?.sections[indexPath.section], indexPath.row < section.cells.count else { return UITableViewCell() }
        let cell = section.cells[indexPath.row]
        switch cell {
        case .productsDetailsCell(let product):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as? ProductDetailsTableViewCell else { return UITableViewCell() }
            cell.viewSetup()
            cell.model = product
            return cell
        case .productListCell(let products):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: suggestedItemsCellId, for: indexPath) as? ProductListTableViewCell else { return UITableViewCell() }
            cell.setUpCell()
            cell.model = products
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let sectionModel = model?.sections[section], let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewId) as? ProductListSectionHeaderView else { return nil }
//        headerView.delegate = self
//        headerView.section = section
//        headerView.model = sectionModel
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}

//MARK:- UITableViewDelegate
extension ProductDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = model?.sections[indexPath.section], indexPath.row < section.cells.count else { return 0 }
        let cell = section.cells[indexPath.row]
        switch cell {
        case .productListCell:
            return 175
        case .productsDetailsCell:
            return 400
        }
    }
}
