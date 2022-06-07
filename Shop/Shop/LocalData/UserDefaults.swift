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
    func isLoggedIn()->Bool
    func getUserName()->String
    func getId()->Int
    func logout()
}
class userDefault:userDefaultsprotocol{
    func logout() {
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.value(forKey: "name") as? String ?? ""

    }
    
    func getId() -> Int {
        return UserDefaults.standard.value(forKey: "id") as? Int ?? 0

    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "IsLoggedIn")
    }
    
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


