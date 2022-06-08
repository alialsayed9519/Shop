//
//  RegisterViewModel.swift
//  Shop
//
//  Created by Salma on 05/06/2022.
//

import Foundation
import RxCocoa
import RxSwift
protocol regTemp{
    var alertMsgDriver:Driver<String> {get}
    var alertMsgSubject:PublishSubject<String>{get}
    func register(firstName:String,lastName:String,email:String,password:String)
    var navigate:()->(){set get}
    
}
class RegisterViewModel:regTemp{
    var navigate={
        print ("navigation")
    }
    
    let network=NetworkService()
    let defaults:userDefaultsprotocol=userDefault()
    var alertMsgDriver:Driver<String>
    var alertMsgSubject = PublishSubject<String>()
    init() {
        alertMsgDriver=alertMsgSubject.asDriver(onErrorJustReturn: "")
    }
    func register(firstName: String, lastName: String, email: String, password: String) {
        if firstName != ""{
            if checkEmailValidation(email: email){
                if password.count<6{
                    let customer = Customers(first_name: firstName, last_name: lastName, email: email, phone: nil, tags: password, id: nil, verified_email: true, addresses: nil)
                   let newCustomer=Customer(customer: customer)
                    register(customer: newCustomer)
                }
                else{
                    alertMsgSubject.onNext("pass must not be less than 6 characters")
                }
                
            }else{
                alertMsgSubject.onNext("please enter a valid email")
            }
        }else{
            alertMsgSubject.onNext("Please your firstName")
        }
        
        
    }
    func register(customer:Customer){
        network.register(newCutomer: customer){[weak self] (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)as! Dictionary<String,Any>
                    let getCustomer = json["customer"] as? Dictionary<String,Any>
                    let id=getCustomer?["id"] as? Int ?? 0
                    let name=getCustomer?["first_name"] as? String ?? ""
                    if id != 0 {
                        self?.defaults.login()
                        self?.defaults.setId(id: id)
                        self?.defaults.setUserNAme(userName:name)
                        DispatchQueue.main.async {
                            self?.navigate()
                        }
                        self?.alertMsgSubject.onNext("registered successfully")
                        print("registered successfully")
                    }
                        else{
                            self?.alertMsgSubject.onNext("An error occurred while registering")
                            print("error occurred while reg")
                        }
                        
                    }
                    
                    
                    
                    
            }
        }
    }
    
}
func checkEmailValidation(email:String)->Bool{
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailpred=NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailpred.evaluate(with: email)
}
