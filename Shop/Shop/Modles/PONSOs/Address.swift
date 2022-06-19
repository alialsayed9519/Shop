//
//  Address.swift
//  Shop
//
//  Created by yasmeen hosny on 6/8/22.
//

import Foundation

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
