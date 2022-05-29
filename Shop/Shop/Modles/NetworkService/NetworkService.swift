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
        AF.request(URLs.getProductsURL())
            .validate()
            .responseDecodable(of: AllProducts.self) { (response) in
                switch response.result {
                    case .success( _):
                    guard let data = response.value else { return }
                    completion(data.products,nil)
                        
                    case .failure(let error):
                        completion(nil , error)
                }
            }
    }
}
