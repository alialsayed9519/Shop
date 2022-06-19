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
    let first_name ,last_name ,note,email,phone,tags:String?
    let id :Int?
    let verified_email:Bool?
    let addresses:[Address]?
    
}
struct Login:Codable{
    let customers:[Customers]
}
