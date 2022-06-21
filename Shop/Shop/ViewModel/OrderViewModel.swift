//
//  OrderViewModel.swift
//  Shop
//
//  Created by yasmeen hosny on 6/19/22.
//

import Foundation


class OrderViewModel {
    
    var bindOrders: (()->()) = {}
    var bindError : (()->()) = {}
    var orders: [OrderFromAPI]! {
        didSet{
            self.bindOrders()
        }
    }
    var error: String!{
        didSet{
            self.bindError()
        }
    }
    
    private var network = NetworkService()
    private var defaults = userDefault()
    
    func checkDescountCode(copun: String) -> (Int, String) {
        
        var copunValue: (Int, String)
        
        switch copun {
        case defaults.getThirtyDescountTitle():
            copunValue = (30, "Nice, now you have 30% off")
        case "SHOPIT30":
            copunValue = (30, "Nice, now you have 30% off")
        case defaults.getFiftyDescountTitle():
            copunValue = (50, "Nice, now you have 50% off")
        case "SHOPIT50":
            copunValue = (50, "Nice, now you have 50% off")
        case "":
            copunValue = (0, "No copun Entered")
        default:
            copunValue = (0, "Invalid copun")
        }
        
        return copunValue
    }
    
    func postOrder(order: Order){
            let myOrder = APIOrder(order: order)
            network.postOrder(order: myOrder) { (data, response, error) in
                if error != nil{
                    print("error while posting order \(error!.localizedDescription)")
                }
                if let data = data{
                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>

                    let returnedOrder = json["order"] as? Dictionary<String,Any>
                    let returnedCustomer = returnedOrder?["customer"] as? Dictionary<String,Any>
                    let id = returnedCustomer?["id"] as? Int ?? 0
                    if id != 0 {
                        print("call empty cart")
                    }
                }
            }
        }
    
    func fetchAllOrders(){
        network.getOrders() { (response, error) in
            if let orderFromAPI = response {
                self.orders = orderFromAPI
            }
            else{
                self.error = error?.localizedDescription
            }
        }
        }
}
