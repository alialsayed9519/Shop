//
//  currencyViewModel.swift
//  Shop
//
//  Created by Salma on 21/06/2022.
//

import UIKit

class currencyViewModel: NSObject {
    var userDefaults:userDefaultsprotocol=userDefault()
    var bindCurrencyViewModel:(()->())={}
    var currency :String?{
        didSet{
            self.bindCurrencyViewModel
        }
    }
    override init(){
        super.init()
        currency=getCurrency(key: "currency")
    }
    func setCurrency(key:String,value:String){
        userDefaults.setCurrency(key: key, value: Value)
        self.currency=value
    }
    func getCurrency(key:String){
        self.currency=userDefaults.getCurrency(key: key)
        return self.currency!
    }
}
