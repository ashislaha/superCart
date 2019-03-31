//
//  ProductCollectionViewCell.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 27/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol ProductCollectionViewCellProtocol: class {
    func itemAdded(_ product: Product)
    func itemRemoved(_ product: Product)
    func viewProductDetails(_ product: Product)
}

class ProductCollectionViewCell: UICollectionViewCell {
    public var model: Product? {
        didSet {
            updateUI()
        }
    }
    public weak var delegate: ProductCollectionViewCellProtocol?
    
    // add a NSCache for caching the images
    private let cacheImages = NSCache<NSString, UIImage>()
    
    // imageview
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "placeholder")
        return imageView
    }()
    // name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        return label
    }()
    // price
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    // selection image
    private let selectionImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage()
        return imageView
    }()

    // edit quantity view
    private let editQuantityView: EditQuantityView = {
        let editQuantityView = EditQuantityView()
        editQuantityView.translatesAutoresizingMaskIntoConstraints = false
        return editQuantityView
    }()
    
    // view details  button
    private let viewDetailsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "info_icon"), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // view loading
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    // clean the collection view cell before reuse
    override func prepareForReuse() {
        nameLabel.text = ""
        imageView.image = #imageLiteral(resourceName: "placeholder")
        priceLabel.text = ""
    }

    private func viewSetup() {
        layoutSetup()
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }

    // MARK:- update UI
    private func updateUI() {
        setName()
        setImage()
        setPrice()
        setQuantity()
        selectionImage.image = model?.isPreselected ?? false ? #imageLiteral(resourceName: "add_to_list_check") : UIImage()
        layer.borderColor = model?.isPreselected ?? false ? UIColor.green.cgColor : UIColor.lightGray.cgColor
    }

    // MARK:- Layout Setup
    private func layoutSetup() {
        [imageView, nameLabel, priceLabel, editQuantityView, viewDetailsButton].forEach{ contentView.addSubview($0) }
        imageView.addSubview(selectionImage)

        editQuantityView.delegate = self
        
        // anchoring
        imageView.anchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 80))
        nameLabel.anchors(top: imageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        priceLabel.anchors(top: nameLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        editQuantityView.anchors(top: priceLabel.bottomAnchor, leading: imageView.leadingAnchor, bottom: bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 8, right: 0), size: .init(width: 0, height: 30))
        selectionImage.anchors(top: imageView.topAnchor, leading: imageView.leadingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 16, height: 16))
        viewDetailsButton.anchors(top: topAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 20, height: 20))

        viewDetailsButton.addTarget(self, action: #selector(viewDetailsTapped), for: .touchUpInside)

    }
}

extension ProductCollectionViewCell {
    private func setName() {
        guard let model = model else { return }
        nameLabel.text = model.productName
    }

    private func setImage() {
        guard let imageUrl = model?.imageUrl else { return }
        loadImage(urlString: imageUrl)
    }
    
    private func loadImage(urlString : String) {
        guard let url = URL(string: urlString), !urlString.isEmpty else { return }
        // check whether the image is present into cache or not
        if let image = cacheImages.object(forKey: NSString(string: urlString)) {
            imageView.image = image
        } else {
            let session = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data , error == nil else { return }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    self?.cacheImages.setObject(image, forKey: NSString(string: urlString)) // setting into cache
                    self?.imageView.image = image
                }
            }
            session.resume()
        }
    }

    private func setPrice() {
        guard let model = model else { return }
        priceLabel.text =  "$ " + "\(model.price)"
    }

    private func setQuantity() {
        guard let model = model else { return }
        editQuantityView.quantity =  model.quantity
    }
    
    @objc private func viewDetailsTapped() {
        guard let model = model else { return }
        delegate?.viewProductDetails(model)
    }
}

extension ProductCollectionViewCell: EditQuantityViewProtocol {
    func quantityUpdated(_ quantity: Int) {
        guard let model = model else { return }
        if quantity != 0 {
            model.quantity = quantity
            if !model.isPreselected {
                delegate?.itemAdded(model)
            }
        } else {
            if model.isPreselected {
                delegate?.itemRemoved(model)
            }
        }
    }
}
