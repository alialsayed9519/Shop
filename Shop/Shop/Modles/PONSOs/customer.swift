//
//  customer.swift
//  Shop
//
//  Created by Salma on 05/06/2022.
//

import Foundation
struct Customer:Codable{
    let customer:Customers
}
struct Customers:Codable{
    let first_name ,last_name ,email,phone,tags:String?
    let id :Int?
    let verified_email:Bool?
    let addresses:[Address]?
    
}
struct Address:Codable{
    var address1 , city ,province ,phone,zip,last_name,firt_name,country :String?
    var id :Int?
}
extension Encodable{
    func asDictionary() throws->[String:Any]{
        let data=try JSONEncoder().encode(self)
        guard let dictionary=try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else{
            throw NSError()
        }
        return dictionary
    }
}

struct Login:Codable{
    let customers:[Customers]
}
