//
//  NetworkService.swift
//  Shop
//
//  Created by Ali on 30/05/2022.
//

import Foundation
import Alamofire


class NetworkService {
    
     func getAllBrands(completion: @escaping ([SmartCollection]?, Error?) -> ()) {
        AF.request(URLs.getCategoriesURL())
             .responseDecodable(of: Brand.self) { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.value else { return }
                    completion(data.smart_collections, nil)
               
                case .failure(let error):
                    completion(nil, error)
                }
            }
     }
       
    func fetchCustomCatagegories(completion:@escaping ([CustomCollection]?, Error?) -> () ){
        AF.request(URLs.customCollections())
            .responseDecodable(of:CustomCollections.self){
            (response) in
            switch response.result{
        case .success(_):
            guard let data = response.value
            else{return}
                print(data.custom_collections?[0].title as Any)
                completion(data.custom_collections, nil)
            case .failure(let error):
                completion(nil,error)
            }
            
        }
    }

     func fetchProducts(collectionID:Int, completion: @escaping ([Product]?, Error?) -> () ){
        AF.request(URLs.products(collectionId: collectionID))
             .responseDecodable(of:AllProducts.self){
            (response) in
            switch response.result{
            case .success(_):
                guard let data=response.value
                else {
                    return
                }
                print(data.products[0].title)
                completion(data.products,nil)
            case .failure(let error) :
                completion(nil,error)
                print(error.localizedDescription)
            }
        }
    }


}
