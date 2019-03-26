//
//  ProductListView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 25/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol ProductListProtocol: class {
    func itemSelected(model: Product, index: Int)
}

class ProductListView: UIView {

    var model: ProductListViewModel?
    weak var delegate: ProductListProtocol?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
