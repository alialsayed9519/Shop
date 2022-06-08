//
//  NetworkService.swift
//  Shop
//
//  Created by Ali on 30/05/2022.
//

import Foundation
import Alamofire


class NetworkService {
    func login(email:String,password:String,completion:@escaping(DataResponse<Login,AFError>)->()){
        AF.request(URLs.customer()).validate().responseDecodable(of:Login.self){
            (response) in
            completion (response)
        }
    }
    func register(newCutomer:Customer,compeletion:@escaping(Data?,URLResponse?,Error?)->()){
        guard let url=URL(string:URLs.customer()) else
        {return}
        var request=URLRequest(url: url)
        request.httpMethod="POST"
        let seesion=URLSession.shared
        request.httpShouldHandleCookies=false
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: newCutomer.asDictionary(), options: .prettyPrinted)}
        catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        seesion.dataTask(with: request) { (data,response,error)in
            compeletion(data,response,error)
        }.resume()
       
    }
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
