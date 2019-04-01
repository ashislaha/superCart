//
//  MessageTableViewCell.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 27/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = ""
    }
    
    private var messageLabel : UILabel  = {
     let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.numberOfLines = 0
     label.lineBreakMode = .byWordWrapping
     label.textColor = .black
     label.textAlignment = .center
     label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
     return label
     }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpCell() {
        layoutSetUp()
    }
    
    private func layoutSetUp() {
        addSubview(messageLabel)

        messageLabel.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
}
