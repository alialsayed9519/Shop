//
//  CoreDataManager.swift
//  Shop
//
//  Created by Ali on 02/06/2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    var appDelegate: AppDelegate?
    
    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    func addProductToFavorite(product: Product) {
        let managedContext =  appDelegate!.persistentContainer.viewContext
        let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "FavoriteList", in: managedContext)
        let favoriteProduct: NSManagedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        favoriteProduct.setValue(product.title, forKey: "title")
        favoriteProduct.setValue(product.id, forKey: "id")
        favoriteProduct.setValue(product.images?[0].src , forKey: "image")
        favoriteProduct.setValue(product.description ?? "No Discription", forKey: "descrp")
        favoriteProduct.setValue(product.variants?[0].price ?? "0", forKey: "price")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteProductFromFavorite(id: Int) {
        let managedContext =  appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteList")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")

        do {
            let favoriteProductList = try managedContext.fetch(fetchRequest)
            for product in favoriteProductList {
                managedContext.delete(product)
            }
            try managedContext.save()

        } catch let error as NSError {
            print(error)
        }
    }
    
    func getAllFavoriteProducts() -> [Product]? {
        var list: [Product] = []
        let managedContext =  appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteList")
        do {
            let favoriteProductList = try managedContext.fetch(fetchRequest)
            for product in favoriteProductList {
                let id = product.value(forKey: "id") as! Int
                let image = product.value(forKey: "image") as! String
                let price = product.value(forKey: "price") as! String
                let description = product.value(forKey: "descrip") as! String
                let title = product.value(forKey: "title") as! String
                let prod = Product(id: id, title: title, description: description, product_type: "", vendor: "", options: nil, images: nil, variants: nil)
                list.append(prod)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return list
    }
    
    
}
