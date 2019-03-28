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
    func getProductsList(products: [[String: Any]], completionHandler: @escaping (([Category])->())) throws {
        let urlStr = "http://demo2354372.mockable.io/productList" //Constants.DataService.endPoint + "/productList"
        guard !urlStr.isEmpty else { throw DataSourceError.InvalidURL }
        let items: [[String: Any]] = [[
            "cat": "dairy",
            "subCat": "milk"
            ]]
        let productsDict: [String: Any] = [
            "id": CurrentSession.sharedInstance.userName ?? "",
            "items": items
        ]
        NetworkLayer.postData(urlString: urlStr, bodyDict: productsDict, requestType: .POST, successBlock: { (response) in
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
