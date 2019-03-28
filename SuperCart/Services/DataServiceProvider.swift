//
//  DataServiceProvider.swift
//  SuperCart
//
//  Created by Nirupama Abraham on 24/03/19.
//  Copyright © 2019 Nirupama Abraham. All rights reserved.
//

import Foundation

// MARK:- DataSourceError
enum DataSourceError: Error {
    case InvalidURL
    case CategoriesGenererationError
    case ErrorInServerData
}

final class DataServiceProvider {
        
    // get products list
    func getProductsList(productsList: [String: Any], completionHandler: @escaping (([Category])->())) throws {
        let urlStr = Constants.DataService.endPoint + "/productList"
        guard !urlStr.isEmpty else { throw DataSourceError.InvalidURL }
        NetworkLayer.postData(urlString: urlStr, bodyDict: productsList, requestType: .POST, successBlock: { (response) in
            // success
            DispatchQueue.main.async {
                guard let response = response as? [String: Any],
                    let categories = response[Constants.Categories.categories] as? [[String:Any]] else {
                    completionHandler([])
                    return
                }
                let categoriesArr = categories.map({ (category) -> Category in
                    let categoryObj = Category(dict: category)
                    return categoryObj
                })
                completionHandler(categoriesArr)
            }
        }) { (error) in
            print(error.debugDescription)
            DispatchQueue.main.async {
                completionHandler([])
            }
        }
    }
}
