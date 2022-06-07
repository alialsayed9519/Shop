//
//  LoginViewModel.swift
//  Shop
//
//  Created by Salma on 07/06/2022.
//

import Foundation
import Alamofire
protocol loginTemp{
    func login(email:String,password:String)
    var notFound:Bool {get set}
    var navigate:Bool {get set}
    var alertMessage:String {get}
    var bindNavigate:(()->()) {get set}
    var bindDontNavigate:(()->()) {get set}
    
}
class LoginViewModel:loginTemp{
    let defaults:userDefaultsprotocol=userDefault()
    let coreData:CoreDataProtocol
    let network=NetworkService()
    init(appdelegate:inout AppDelegate){
        coreData=CoreDataRepo(appdelegate: &appdelegate)
    }
    func login(email: String, password: String) {
        if checkEmailValidation(email: email){
            if password.count >= 6{
                network.login(email: email, password: password){[weak self]
                    (respose) in
                    switch respose.result{
                    case .success(_):
                        guard let responseValue=respose.value
                        else {return}
                        let customers=responseValue.customers
                        for customer in customers {
                            let comingEmail=customer.email ?? ""
                            let comingPassword = customer.tags ?? ""
                            if comingEmail==email && comingPassword==password{
                                print("user found")
                                self?.defaults.logout()
                                self?.defaults.setId(id: customer.id ?? 0)
                                if customer.addresses?.count ?? 0>0 && customer.addresses?[0].address1 != ""{
                                    for address in customer.addresses!{
                                        self?.coreData.setAddress(address: address)
                                    }
                                }
                                self?.navigate=true
                                break
                            }
                        }
                        guard let _=self?.navigate
                        else{
                            self?.notFound=true
                            self?.alertMessage="can not login"
                            return
                        }
                    case .failure(let error):
                        self?.alertMessage="an error ocurred while login"
                        print(error)
                        
                    }
                }
            }else{
                alertMessage="password should be at least 6 characters"
            }
        }
            else{
                alertMessage="enter valid email"
            
            
        }
    }
    
    var notFound: Bool{
        didSet{
            bindDontNavigate()
        }
    }
    
    var navigate: Bool{
        didSet
        {
        bindNavigate()
        }
    }
    
    var alertMessage: String{
        didSet{
        bindDontNavigate()
        }
    }
    
    var bindNavigate:(()->()) = {}
    
    var bindDontNavigate: (() -> ())={}
    
    
}
