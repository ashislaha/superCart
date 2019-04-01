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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel?.text = ""
    }
    
    private var messageLabel : UILabel?

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
        messageLabel = UILabel(frame: bounds)
        addSubview(messageLabel!)
        messageLabel?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        messageLabel?.numberOfLines = 0
        messageLabel?.lineBreakMode = .byWordWrapping
        messageLabel?.textColor = .black
        messageLabel?.textAlignment = .center
        messageLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}
