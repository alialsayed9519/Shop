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
    
    func fetchAddresses(completion: @escaping ([Address]?, Error?) -> () ){
        
        let customerID = userDefault().getId()
        AF.request(URLs.allAddresses(customerId: customerID))
            .responseDecodable(of: CustomerAddresses.self){ (response) in
                
                switch response.result{
                case .success(_):
                    guard let data = response.value else { return }
                   // print(data.addresses![0].city)
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
 
    func postNewDraftOrder(order: Api, completion: @escaping (Data?, URLResponse?, Error?)->()) {
        guard let url = URL(string: URLs.getDraftOrdersURL()) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: order.asDictionary(), options: .prettyPrinted)
          
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }

    func getSingleDraftOrder(id: String, completion: @escaping ([LineItem]?, Error?)->()){
        AF.request(URLs.getSingleDraftOrder(id: id))
             .responseDecodable(of: Draft.self) { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.value else { return }
                    completion(data.draft_order.line_items, nil)
               
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
   
    func getProductImageById(id: String , completion: @escaping (String?, Error?)->()){
        AF.request(URLs.getProductImage(id: id))
             .responseDecodable(of: Images.self) { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.value else { return }
                    completion(data.images[0].src, nil)
               
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    func removeAnExistingDraftOrder(id: String , completion: @escaping (Data?, URLResponse?, Error?)->()){
        guard let url = URL(string: URLs.deleteDraftOrder(id: id)) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let session = URLSession.shared
             
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
             
    }
    
    func ModifyAnExistingDraftOrder(id: String, order: Updated, completion: @escaping (Data?, URLResponse?, Error?)->()) {
        guard let url = URL(string: URLs.modifyDeraftOrder(id: id)) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let session = URLSession.shared
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: order.asDictionary(), options: .prettyPrinted)
          
        } catch let error {
            print(error.localizedDescription)
        }
        print(try? order.asDictionary())
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpShouldHandleCookies = false

        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    func fetchPriceRules(completion:@escaping ([Price_Rule]?, Error?)->()){
    AF.request(URLs.priceRole())
        .responseDecodable(of:Price_Rules.self){(response) in
            switch response.result{
                case .success(_):
                    guard let data = response.value
                    else{
                        return
                    }
                    completion(data.price_rules, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
    
    func postOrder(order: APIOrder, completion: @escaping (Data?, URLResponse?, Error?)->()){
       guard let url = URL(string: URLs.order()) else {return}
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: order.asDictionary(), options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()

    }


    func getCustomerById(id: String, completion: @escaping (User?, Error?)->()){
        AF.request(URLs.customer(id: id))
             .responseDecodable(of: User.self) { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.value else { return }
                    completion(data, nil)
               
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    func updateCustomerNote(id: String, user: User, completion: @escaping (Data?, URLResponse?, Error?)->()) {
        guard let url = URL(string: URLs.customer(id: id)) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let session = URLSession.shared
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user.asDictionary(), options: .prettyPrinted)
          
        } catch let error {
            print(error.localizedDescription)
        }
        print(try? user.asDictionary())
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpShouldHandleCookies = false

        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }


    func getProductBySubCategory(collectionId: Int, productType: String, completion:@escaping ([Product]?,Error?)->()){
        AF.request(URLs.productsForSubCategory(collectionId: collectionId, productType: productType))
             .responseDecodable(of:AllProducts.self){
            (response) in
            switch response.result{
            case .success(_):
                guard let data = response.value
                else {
                    return
                }
                completion(data.products,nil)
            case .failure(let error) :
                completion(nil,error)
                print(error.localizedDescription)
            }
        }
    }
    
    func updateCustomerFav(id: String, user: User, completion: @escaping (Data?, URLResponse?, Error?)->()) {
        guard let url = URL(string: URLs.customer(id: id)) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let session = URLSession.shared
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user.asDictionary(), options: .prettyPrinted)
          
        } catch let error {
            print(error.localizedDescription)
        }
        print(try? user.asDictionary())
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpShouldHandleCookies = false

        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
