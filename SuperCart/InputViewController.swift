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
        trackUserAgent()
    }
    
    @IBAction func takeHandwrittenImage(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: "We are working on this to train our hand-written classfier.", message: "Get back soon", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func chatWithWalmartRobo(_ sender: UIButton) {
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
