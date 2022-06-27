//
//  UserDefaults.swift
//  Shop
//
//  Created by Salma on 06/06/2022.
//

import Foundation
protocol userDefaultsprotocol{
    func setUserName(userName:String)
    func setId(id:Int)
    func login()
    func isLoggedIn()->Bool
    func getUserName()->String
    func getId()->Int
    func logout()
    func setDraftOrder(note: String)
    func getDraftOrder() -> String
    func setEmail(email:String)
    func getEmail() -> String
    func setCurrency(key:String,value:String)
    func getCurrency(key:String)->String
}
class userDefault: userDefaultsprotocol{
    func setCurrency(key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getCurrency(key: String = "currency") -> String {
        let currency=UserDefaults.standard.string(forKey: key)
        if currency==""{
            return "USD"
        }
        return currency ?? "USD"
    }
    func getEmail() -> String {
        return UserDefaults.standard.value(forKey:"email") as? String ?? ""
    }
    
    func setEmail(email:String) {
        UserDefaults.standard.set(email, forKey: "email")
    }
    
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
    
    func setUserName(userName: String) {
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
    
    func setDraftOrder(note: String){
        UserDefaults.standard.set(note, forKey: "draftOrderId")
    }
    
    func getDraftOrder() -> String {
        UserDefaults.standard.value(forKey: "draftOrderId") as? String ?? ""
    }
    
    func setCurrency(currency: String){
        UserDefaults.standard.set(currency, forKey: "currency")
    }
    
    func getCurrency() -> String {
        UserDefaults.standard.value(forKey: "currency") as? String ?? "USD"
    }
}


