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

     func fetchbrandProducts(collectionTitle:String, completion: @escaping ([Product]?, Error?) -> () ){
        AF.request(URLs.brandproducts(collectionTitle:collectionTitle))
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
    func fetchAddresses(completion: @escaping ([Address]?, Error?) -> () ){
        
        let customerID = userDefault().getId()
        AF.request(URLs.AllAddresses(customerId: customerID))
            .responseDecodable(of: CustomerAddresses.self){ (response) in
                
                switch response.result{
                case .success(_):
                    guard let data = response.value else { return }
                    print(data.addresses![0].city)
                    completion(data.addresses,nil)
                case .failure(let error) :
                    completion(nil,error)
                    print(error.localizedDescription)
                }
            }
    }
    
    func addAddress(id: Int, address: Address, completion: @escaping(Data?, URLResponse?, Error?)->()){
        
        let customer = CustomerAddresses(addresses: [address])
        let putObject = PutAddress(customer: customer)
        guard let url = URL(string: URLs.customer(id: "\(id)")) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: putObject.asDictionary(), options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
           
        //MARK: HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
           
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
       
       func editAddress(id: Int, address: Address, completion: @escaping(Data?, URLResponse?, Error?)->()){
        updateCustomerAddresses(httpMethod: "PUT", id: id, completion: completion)
    }

       
    func deleteAddress(id: Int, completion: @escaping(Data?, URLResponse?, Error?)->()){
        updateCustomerAddresses(httpMethod: "DELETE", id: id, completion: completion)
    }
    
    private func updateCustomerAddresses(httpMethod: String, id: Int, completion: @escaping(Data?, URLResponse?, Error?)->()){
        let addressId = id
        let customerId = userDefault().getId()
        guard let url = URL(string: URLs.oneAddress(customerId: customerId, addressId: addressId)) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
           
        //MARK: HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
           
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    func fetchAllProducts(completion:@escaping ([Product]?,Error?)->()){
        AF.request(URLs.allProducts()).responseDecodable(of:AllProducts.self){
            (response) in
            switch response.result{
            case .success(_):
                guard let data=response.value
                else{
                    return
                }
                completion(data.products,nil)
            case .failure(let error):
                completion(nil,error)
            
                
            }
        }
        
    }
}
