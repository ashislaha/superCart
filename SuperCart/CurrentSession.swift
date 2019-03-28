//
//  CurrentSession.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 28/03/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation

class CurrentSession: NSObject {
    static let sharedInstance = CurrentSession()
    
    var userName: String?
    var password: String?
}
