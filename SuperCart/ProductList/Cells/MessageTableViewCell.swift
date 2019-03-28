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
            messageLabel?.text = message
        }
    }
    
    private var messageLabel : UILabel? /* = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }() */

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func setUpCell() {
        layoutSetUp()
    }
    
    private func layoutSetUp() {
        
        messageLabel = UILabel(frame: bounds)
        addSubview(messageLabel!)
        messageLabel?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        messageLabel?.numberOfLines = 0
        messageLabel?.lineBreakMode = .byWordWrapping
        messageLabel?.textColor = .black
        messageLabel?.textAlignment = .center
        messageLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)

//        addSubview(messageLabel)
//
//        messageLabel.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }

}
