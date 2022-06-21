//
//  OrderViewModel.swift
//  Shop
//
//  Created by yasmeen hosny on 6/19/22.
//

import Foundation


class OrderViewModel {
    
    private var network = NetworkService()
    private var defaults = userDefault()
    private let draftOrderViewModel = DraftOrderViewModel()
    func checkDescountCode(copun: String) -> (Int, String) {
        
        var copunValue: (Int, String)
        
        switch copun {
        case defaults.getThirtyDescountTitle():
            copunValue = (30, "Nice, now you have 30% off")
        case defaults.getFiftyDescountTitle():
            copunValue = (50, "Nice, now you have 50% off")
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
                        self.draftOrderViewModel.deleteAnExistingDraftOrder(id: userDefault().getDraftOrder())
                    }
                }
            }
        }
}
