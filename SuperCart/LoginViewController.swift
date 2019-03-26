//
//  ViewController.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/23/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak private var userName: UITextField!
    @IBOutlet weak private var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let userName = userName.text, let password = password.text, !userName.isEmpty, !password.isEmpty else { return }
        
        guard let inputVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputViewController") as? InputViewController else { return }
        
        ProductsManager.shared.username = userName
        navigationController?.pushViewController(inputVC, animated: true)
    }
}

