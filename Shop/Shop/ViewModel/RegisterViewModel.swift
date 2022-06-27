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
    var title:String? { get}
    var message:String?{get}
    var alertMsgDriver:Driver<String> {get}
    var alertMsgSubject:PublishSubject<String>{get}
    func register(firstName:String,lastName:String,email:String,password:String)
    var navigate:()->(){set get}
    
}
class RegisterViewModel:regTemp{
    var message: String?
    
    var title: String?
    
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
            if lastName != ""{
            if checkEmailValidation(email: email){
                if password.count >= 6{
                    let customer = Customers(first_name: "\(firstName) \(lastName)", last_name: "0", note: "0", email: email, phone: nil, tags: password, id: nil, verified_email: true, addresses: nil)
                   let newCustomer=Customer(customer: customer)
                    register(customer: newCustomer)
                }
                else{
                    alertMsgSubject.onNext("Password should be 6 characters at least")
                    title="Warning"
                    message="Password should be 6 characters at least"
                    //showAlert(title: passt, message: message)
                }
                
            }else{
                alertMsgSubject.onNext("please enter a valid email")
                title="Warning"
                message="please enter a valid email"
            }
                
        }
            else{
                alertMsgSubject.onNext("Please your lastname")
                title="Warning"
                message="Please your firstName"
            }
        }
            
            else{
            alertMsgSubject.onNext("Please your firstName")
            title="Warning"
            message="Please your firstName"
                showAlert(title: "first", message: "mmmM", view: registerVc())
        }
        
        
    }
  
    func register(customer:Customer){
        network.register(newCutomer: customer){[weak self] (data, response, error) in
            if error != nil {
                print(error!)
            } else {                if let data = data {
                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)as! Dictionary<String,Any>
                    let getCustomer = json["customer"] as? Dictionary<String,Any>
                    let id = getCustomer?["id"] as? Int ?? 0
                    let firstName = getCustomer?["first_name"] as? String ?? ""
                    let lastName=getCustomer?["last_name"] as? String ?? ""
                    let name = firstName+lastName
                    let draftId = getCustomer?["note"] as? String ?? "false"
                    let email=getCustomer?["email"] as? String ?? ""
                    let fav = getCustomer?["phone"] as? String ?? ""
                    
                    if id != 0 {
                        self?.defaults.login()
                        self?.defaults.setId(id: id)
                        self?.defaults.setEmail(email: email)
                        self?.defaults.setUserName(userName: firstName)
                        self?.defaults.setDraftOrder(note: draftId)
                        DispatchQueue.main.async {
                            self?.navigate()
                        }
                        self?.alertMsgSubject.onNext("registered successfully")
                        print("registered successfully")
                        self?.title="Congratulations"
                        self?.message="registered successfully"
                    }
                        else{
                            self?.alertMsgSubject.onNext("An error occurred while registering")
                            print("error occurred while reg")
                            self?.title="Error"
                            self?.message="An error occurred while registering"
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
