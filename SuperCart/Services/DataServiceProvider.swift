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
    func getProductsList(productsList: [String: Any], completionHandler: @escaping ((ProductsList?)->())) throws {
        
        let urlStr = Constants.DataService.endPoint + "/productList"
        guard !urlStr.isEmpty else { throw DataSourceError.InvalidURL }
        NetworkLayer.postData(urlString: urlStr, bodyDict: productsList, requestType: .POST, successBlock: { (response) in
            // success
            DispatchQueue.main.async {
                guard let responseDict = response as? [String: Any] else {
                    completionHandler(nil)
                    return
                }
                let productList = ProductsList(dict: responseDict)
                var products = productList.categories.flatMap({ (category) -> [Product] in
                    return category.products
                })
                products.append(contentsOf: productList.missingItems)
                AppManager.shared.products = products
                
                completionHandler(productList)
            }
        }) { (error) in
            print(error.debugDescription)
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
    }
    
    //get product details
    func getProductDetails(productId: String, completionHandler: @escaping (([String: Any]?)->())) throws {
        let urlStr = Constants.DataService.endPoint + "/productDetails/\(productId)"
        guard let url = URL(string: urlStr), !urlStr.isEmpty else { throw DataSourceError.InvalidURL }
        
        NetworkLayer.getData(url: url, successBlock: { (response) in
            // success
            DispatchQueue.main.async {
                guard let response = response as? [String: Any] else {
                    completionHandler(nil)
                    return
                }
                completionHandler(response)
            }
        }) { (error) in
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
    }
    
    //place order
    func placeOrder(products: [[String: Any]], completionHandler: @escaping ((Bool)->())) throws {
        let urlStr = Constants.DataService.endPoint + "/placeOrder"
        guard !urlStr.isEmpty else { throw DataSourceError.InvalidURL }
        let postDict: [String: Any] = [
            "id": AppManager.shared.username ?? "",
            "items": products
        ]
        
        NetworkLayer.postData(urlString: urlStr, bodyDict: postDict, requestType: .POST, successBlock: { (response) in
            // success
            DispatchQueue.main.async {
                guard let _ = response as? [String: Any] else {
                    completionHandler(false)
                    return
                }
                completionHandler(true)
            }
        }) { (error) in
            print(error.debugDescription)
            DispatchQueue.main.async {
                completionHandler(false)
            }
        }
    }
}
