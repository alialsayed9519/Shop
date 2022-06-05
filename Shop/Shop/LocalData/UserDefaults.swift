//
//  UserDefaults.swift
//  Shop
//
//  Created by Salma on 06/06/2022.
//

import Foundation
protocol userDefaultsprotocol{
    func addUserNAme(userName:String)
    func addId(id:Int)
    func login()
}
class userDefault:userDefaultsprotocol{
    let Defaults=UserDefaults.standard
    func addUserNAme(userName: String) {
        UserDefaults.standard.set(userName, forKey: "name")
    }
    func addId(id: Int) {
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    func login() {
        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
    }
}


