//
//  FavoriteViewController.swift
//  Shop
//
//  Created by Ali on 01/06/2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet weak var noProductsLabel: UILabel!
    private var favProducts = [Product]()
    private let favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Favorite"
        
        let nibCell = UINib(nibName: "CatagoryCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "CatagoryCollectionViewCell")
        favoriteViewModel.bindFavoriteProductsToFavoriteViewController = { self.BindData() }
        favoriteViewModel.getAllFavoriteProductsFromDataCore()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        if favoriteViewModel.isFavoriteProductsExistinCoreData() {
            noProductsLabel.isHidden = true
        }
    }
    
    func BindData(){
        favProducts = favoriteViewModel.favoriteProducts ?? []
        self.collectionView.reloadData()
    }
    
}

// MARK: CollectionView Methods
extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCollectionViewCell", for: indexPath) as! CatagoryCollectionViewCell
        
        cell.favProductBtn.tag = indexPath.row
        cell.favProductBtn.addTarget(self, action: #selector(deleteProductFromFav), for: .touchUpInside)
        
        let product = favProducts[indexPath.row]
        cell.updateUI(product: product)
                
        return cell
    }
    
    @objc func deleteProductFromFav(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        favoriteViewModel.deleteProductFromFavoriteWith(id: favProducts[index.row].variants![0].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width-10)/2
            let height = view.frame.size.height / 4
            return CGSize(width: side, height: height)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}


