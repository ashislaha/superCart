//
//  InputViewController.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/25/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Take Input"
    }
    
    @IBAction func takeHandwrittenImage(_ sender: UIButton) {
        
        
    }
    
    @IBAction func chatWithWalmartRobo(_ sender: UIButton) {
        guard let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        navigationController?.pushViewController(chatVC, animated: true)
    }
}