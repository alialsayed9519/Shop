//
//  NetworkService.swift
//  Shop
//
//  Created by Ali on 29/05/2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func fetchAllProducts(completion : @escaping ([Product]?, Error?)->()){
        AF.request(URLs.getProductsURL)
    }
}
