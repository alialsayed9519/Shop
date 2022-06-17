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
    func setFiftyDescountID(id: Int){
        UserDefaults.standard.set(id, forKey: "fiftyDescountID")
    }
    func setFiftyDescountTitle(title: String) {
        UserDefaults.standard.set(title, forKey: "fiftyDescountTitle")
    }
    func getFiftyDescountID() -> Int{
        UserDefaults.standard.value(forKey: "fiftyDescountID") as? Int ?? 0
    }
    func getFiftyDescountTitle() -> String{
        UserDefaults.standard.value(forKey: "fiftyDescountTitle") as? String ?? ""
    }
    func setThirtyDescountID(id: Int){
        UserDefaults.standard.set(id, forKey: "thirtyDescountID")
    }
    func setThirtyDescountTitle(title: String) {
        UserDefaults.standard.set(title, forKey: "thirtyDescountTitle")
    }
    func getThirtyDescountID() -> Int{
        UserDefaults.standard.value(forKey: "thirtyDescountID") as? Int ?? 0
    }
    func getThirtyDescountTitle() -> String{
        UserDefaults.standard.value(forKey: "thirtyDescountTitle") as? String ?? ""
    }
    func setDescountMessage(message: String){
        UserDefaults.standard.set(message, forKey: "descountMessage")
    }
    func getDescountMessage() -> String {
        UserDefaults.standard.value(forKey: "descountMessage") as? String ?? ""
    }
}


