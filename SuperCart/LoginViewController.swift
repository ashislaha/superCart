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
        
//        guard let inputVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputViewController") as? InputViewController else { return }
//        navigationController?.pushViewController(inputVC, animated: true)

        AppManager.shared.username = userName
        AppManager.shared.userAgent["username"] = userName
        guard let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        navigationController?.pushViewController(chatVC, animated: true)
        
    }
}

