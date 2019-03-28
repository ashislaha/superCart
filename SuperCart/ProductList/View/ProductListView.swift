//
//  ProductListView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol ProductListProtocol: class {
    func itemSelected(model: Product)
    func itemRemoved(model: Product)
}

class ProductListView: UIView {

    // private properties
    private let productCellId = "productCellID"
    private let messageCellId = "messageCellID"
    private let headerViewId = "headerViewID"
    private var model: ProductListViewModel?
    private var tableView: UITableView!

    // public properties
    public weak var delegate: ProductListProtocol?
    public var categories: [Category]? {
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
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: productCellId)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: messageCellId)
        tableView.register(ProductListSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: headerViewId)
        tableView.allowsSelection = true
        tableView.estimatedRowHeight = 150
        backgroundColor = .white
    }
}

//MARK:- UITableViewDataSource
extension ProductListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = model?.sections[section] else { return 0 }
        return section.isOpen ? section.cells.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = model?.sections[indexPath.section], indexPath.row < section.cells.count else { return UITableViewCell() }
        let cell = section.cells[indexPath.row]
        switch cell {
        case .productCell(let products):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath) as? ProductListTableViewCell else { return UITableViewCell() }
            cell.setUpCell()
            cell.delegate = self
            cell.model = products
            return cell
        case .messageCell(let message):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: messageCellId, for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
            cell.setUpCell()
            cell.message = message
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionModel = model?.sections[section], let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewId) as? ProductListSectionHeaderView else { return nil }
        headerView.delegate = self
        headerView.section = section
        headerView.model = sectionModel
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}

//MARK:- UITableViewDelegate
extension ProductListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = model?.sections[indexPath.section], indexPath.row < section.cells.count else { return 0 }
        let cell = section.cells[indexPath.row]
        switch cell {
        case .productCell:
            return section.isOpen ? 150 : 0
        case .messageCell:
            return UITableView.automaticDimension
        }
    }
}

//MARK:- UITableViewDelegate
extension ProductListView: ProductListTableViewCellProtocol {
    func itemAdded(_ product: Product) {
        delegate?.itemSelected(model: product)
        product.isPreselected = true
        tableView.reloadData()
    }
    
    func itemRemoved(_ product: Product) {
        delegate?.itemRemoved(model: product)
        product.isPreselected = false
        tableView.reloadData()
    }
    
}

//MARK:- ProductListSectionHeaderViewProtocol
extension ProductListView: ProductListSectionHeaderViewProtocol {
    func reloadSection(_ section: Int, isOpen: Bool) {
        guard var sectionModel = model?.sections[section] else { return }
        sectionModel.isOpen = isOpen
        model?.sections[section] = sectionModel
        tableView.reloadSections([section], with: .automatic)
    }
}
