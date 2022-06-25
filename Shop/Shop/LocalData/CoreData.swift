//
//  CoreData.swift
//  Shop
//
//  Created by Salma on 07/06/2022.
//

import Foundation
import CoreData
protocol CoreDataProtocol{
    func setAddress(address:Address)
}


class CoreDataRepo:CoreDataProtocol{
    var delegate:AppDelegate
    init(appdelegate:inout AppDelegate){
        delegate=appdelegate
    }
    
    func setAddress(address: Address) {
        let managedContext = delegate.persistentContainer.viewContext
        let addEntity = NSEntityDescription.entity(forEntityName: "address", in: managedContext)
        let addresscore = NSManagedObject(entity: addEntity!, insertInto: managedContext)
        addresscore.setValue(address.country, forKey: "country")
        addresscore.setValue(address.address1, forKey: "address1")
        addresscore.setValue(address.id, forKey: "id")
        addresscore.setValue(address.city, forKey: "city")
        addresscore.setValue(address.phone, forKey: "phone")
        do{
           try managedContext.save()}
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    
}

 
