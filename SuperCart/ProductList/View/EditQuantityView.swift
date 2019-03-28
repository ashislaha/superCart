//
//  EditQuantityView.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 27/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol EditQuantityViewProtocol: class {
    func quantityUpdated(_ quantity: Int)
}

class EditQuantityView: UIView {

    private let quantityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "iconListAdd"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let removeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "button_less"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()

    weak var delegate: EditQuantityViewProtocol?
    public var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity)"
        }
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func layoutSetUp() {
        
        [addButton, quantityLabel, removeButton].forEach { addSubview($0) }
        
        addButton.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        addButton.widthAnchor.constraint(equalToConstant: 20).isActive = true

        quantityLabel.anchors(top: topAnchor, leading: addButton.trailingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        removeButton.anchors(top: topAnchor, leading: quantityLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        removeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true

        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)

    }
    
    @objc private func addButtonTapped() {
        quantity += 1
        delegate?.quantityUpdated(quantity)
    }

    @objc private func removeButtonTapped() {
        quantity -= 1
        delegate?.quantityUpdated(quantity)
    }
}
