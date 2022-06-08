//
//  Address.swift
//  Shop
//
//  Created by yasmeen hosny on 6/8/22.
//

import Foundation

struct Customer: Codable {
    let first_name, last_name, email, phone, tags: String?
    let id: Int?
    let verified_email: Bool?
    let addresses: [Address]?
}

struct Address: Codable {
    var address1, city, province, phone: String?
    var zip, last_name, first_name, country: String?
    var id: Int!
}

struct CustomerAddresses: Codable {
    var addresses: [Address]?
}

struct UpdateAddress: Codable {
    var address: Address
}

struct PutAddress: Codable {
    let customer: CustomerAddresses?
}
