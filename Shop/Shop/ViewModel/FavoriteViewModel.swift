//
//  FavoriteViewModel.swift
//  Shop
//
//  Created by Ali on 05/06/2022.
//

import Foundation

class FavoriteViewModel {
    private let coreDataManager: CoreDataManager!
    var bindFavoriteProductsToFavoriteViewController: (() -> ()) = {}
    var favoriteProducts: [Product]? {
        didSet {
            self.bindFavoriteProductsToFavoriteViewController()
        }
    }

    init() {
       coreDataManager = CoreDataManager()
   }
    
    func addProductToFavorite(product: Product) {
        if isProductFavoriteWith(id: product.variants![0].id) {
            print("can not add it to fav")
            return
        }
        print("can add it to fav")
        coreDataManager.addProductToFavorite(product: product)
        self.favoriteProducts = coreDataManager.getAllFavoriteProducts()
    }
    
    func isProductFavoriteWith(id: Int) -> Bool{
        let favProducts = coreDataManager.getAllFavoriteProducts()
        for prod in favProducts {
            if id == prod.variants![0].id {
                return true
            }
        }
        return false
    }
    
    func getAllFavoriteProductsFromDataCore() {
        print("getAllFavoriteProductsFromDataCore")
        self.favoriteProducts = coreDataManager.getAllFavoriteProducts()
    }
    
    func deleteProductFromFavoriteWith(id: Int) {
        coreDataManager.deleteProductFromFavorite(id: id)
        self.favoriteProducts = coreDataManager.getAllFavoriteProducts()
    }
    
}
