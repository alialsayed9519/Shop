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
                print(response)
                switch response.result {
                case .success(_):
                    guard let data = response.value else { return }
                    print("\(data.smart_collections?.count ?? 0)  empty array")
                    print("NetworkService")
                    completion(data.smart_collections, nil)
               
                case .failure(let error):
                    print("ddddd")
                    completion(nil, error)
                }
            }
       
func fetchCustomCatagegories(completion:@escaping ([CustomCollections]?,Error?)->()){
        AF.request(URLs.customCollections()).validate().responseDecodable(of:CustomCollection.self){
            (response) in
            switch response.result{
        case .success(_):
            guard let data=response.value
            else{return}
                completion(data.custom_collections,nil)
            case .failure(let error):
                completion(nil,error)
            }
            
        }
    }
     func getProducts(collectionID:String,completion:@escaping([Product]?,Error?)->()){
        AF.request(URLs.products(collectionId: collectionID)).validate().responseDecodable(of:AllProducts.self){
            (response) in
            switch response.result{
            case .success(_):
                guard let data=response.value
                else {
                    return
                }
                completion(data.products,nil)
            case .failure(let error) :
                completion(nil,error)
            
                
            }
        }
    }


