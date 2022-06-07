//
//  UserDefaults.swift
//  Shop
//
//  Created by Salma on 06/06/2022.
//

import Foundation
protocol userDefaultsprotocol{
    func setUserNAme(userName:String)
    func setId(id:Int)
    func login()
    
}
class userDefault:userDefaultsprotocol{
    let Defaults=UserDefaults.standard
    func setUserNAme(userName: String) {
        UserDefaults.standard.set(userName, forKey: "name")
    }
    func setId(id: Int) {
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    func login() {
        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
    }
}


