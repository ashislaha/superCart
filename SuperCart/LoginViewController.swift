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
        trackUserAgent()
        
        guard let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    private func trackUserAgent() {
        
        let registedBefore = UserDefaults.standard.value(forKey: "user_agent") as? Bool ?? false
        guard !AppManager.shared.userAgent.isEmpty && !registedBefore else { return }
        
        let registerDeviceUrl = Constants.DataService.endPoint + "/registerDevice"
        NetworkLayer.postData(urlString: registerDeviceUrl, bodyDict: AppManager.shared.userAgent, requestType: .POST, successBlock: { (_) in
            print("registed the device sucessfully")
            UserDefaults.standard.set(true, forKey: "user_agent")
            UserDefaults.standard.synchronize()
        }) { (_) in
            print("device registed did not happen")
        }
    }

}

