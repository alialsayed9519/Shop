//
//  FavoriteViewController.swift
//  Shop
//
//  Created by Ali on 01/06/2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    let coreDataManager = CoreDataManager()
    private var favProducts = [Product]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Favorite"
        // Do any additional setup after loading the view.
       // collectionView.registerNib(cell: CatagoryCollectionViewCell.self)
        let nibCell = UINib(nibName: "CatagoryCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "CatagoryCollectionViewCell")
        
        favProducts = coreDataManager.getAllFavoriteProducts() ?? []
        print(favProducts.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
}

// MARK: CollectionView Methods
extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("\(favProducts.count)  nnnnnnnnnn")
        return favProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCollectionViewCell", for: indexPath) as! CatagoryCollectionViewCell
        
        let product = favProducts[indexPath.row]
        cell.updateUI(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width - 30 )/3
            return CGSize(width: side, height: side)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}


