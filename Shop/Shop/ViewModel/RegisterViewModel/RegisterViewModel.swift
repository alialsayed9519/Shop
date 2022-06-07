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
    
}
class RegisterViewModel:regTemp{
    let network=NetworkService()
    let defaults:userDefaultsprotocol=userDefault()
    var alertMsgDriver:Driver<String>
    var alertMsgSubject = PublishSubject<String>()
    init() {
        alertMsgDriver=alertMsgSubject.asDriver(onErrorJustReturn: "")
    }
    func register(firstName: String, lastName: String, email: String, password: String) {
        if firstName != ""{
            if password.count>=6{
                if checkEmailValidation(email: email){
                    let customer = Customers(first_name: firstName, last_name: lastName, email: email, phone: nil, tags: password, id: nil, verified_email: true, addresses: nil)
                   let newCustomer=Customer(customer: customer)
                    register(customer: newCustomer)
                }
                else{
                    alertMsgSubject.onNext("Please enter a valid mail")
                }
                
            }else{
                alertMsgSubject.onNext("Pass must be 6 characters at lest")
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
                        self?.alertMsgSubject.onNext("registered successfully")}
                        else{
                            self?.alertMsgSubject.onNext("An error occurred while registering")
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
