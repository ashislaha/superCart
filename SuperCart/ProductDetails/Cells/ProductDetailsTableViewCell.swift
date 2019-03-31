//
//  ProductDetailsTableViewCell.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 30/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class ProductDetailsTableViewCell: UITableViewCell {

    public var model: Product? {
        didSet {
            updateUI()
        }
    }
    
    // add a NSCache for caching the images
    private let cacheImages = NSCache<NSString, UIImage>()
    
    // imageVw
    private let imageVw: UIImageView = {
        let imageVw = UIImageView()
        imageVw.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageVw.contentMode = .scaleAspectFit
        imageVw.image = #imageLiteral(resourceName: "placeholder")
        return imageVw
    }()
    // name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    // brand
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    // category
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    // view loading
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    // clean the collection view cell before reuse
    override func prepareForReuse() {
        nameLabel.text = ""
        imageVw.image = #imageLiteral(resourceName: "placeholder")
        priceLabel.text = ""
        brandLabel.text = ""
        categoryLabel.text = ""
    }
    
    func viewSetup() {
        layoutSetup()
    }
    
    // MARK:- update UI
    private func updateUI() {
        setName()
        setImage()
        setPrice()
        setBrand()
        setCategory()
    }
    
    // MARK:- Layout Setup
    private func layoutSetup() {
        [imageVw, nameLabel, priceLabel, brandLabel, categoryLabel].forEach{ contentView.addSubview($0) }
        // anchoring
        imageVw.anchors(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 200))
        nameLabel.anchors(top: imageVw.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        priceLabel.anchors(top: nameLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 16))
        brandLabel.anchors(top: priceLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 16))
        categoryLabel.anchors(top: brandLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 16))
        
    }

}

extension ProductDetailsTableViewCell {
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
            imageVw.image = image
        } else {
            let session = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data , error == nil else { return }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    self?.cacheImages.setObject(image, forKey: NSString(string: urlString)) // setting into cache
                    self?.imageVw.image = image
                }
            }
            session.resume()
        }
    }
    
    private func setPrice() {
        guard let model = model else { return }
        priceLabel.text =  "$ " + "\(model.price)"
    }

    private func setBrand() {
        guard let model = model else { return }
        brandLabel.text =  "Brand: " + model.brand
    }

    private func setCategory() {
        guard let model = model else { return }
        categoryLabel.text =  "Category: " + model.category
    }
}
