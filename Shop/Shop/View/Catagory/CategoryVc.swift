//
//  CategoryVc.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit

class CategoryVc: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UIToolbar!
    
    
    private var products = [Product]()
    private var mainCategory = [CustomCollection]()
    private var brands: [Brand] = []
    
    private let shopViewModel = ShopingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.registerNib(cell: CatagoryCollectionViewCell.self)

        for _ in 1...30 {
            let brand = Brand(name: "Adidas", image: "adidas")
            brands.append(brand)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }

    @IBAction func tabBarItemSelected(_ sender: Any) {
        shopViewModel.filterPorductsByMainCategory()
    }
    
        
    
}

// MARK: CollectionView Methods
extension CategoryVc: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueNib(indexPath: indexPath) as! CatagoryCollectionViewCell
        let brand = brands[indexPath.row]
        cell.updateUI(brand: brand)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width - 30 )/3
            return CGSize(width: side, height: side)  
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brand = brands[indexPath.row]
        print("\(brand.name) in index  \(indexPath.row + 1)")
    }
}

// MARK: TabBar Items' Action
extension CategoryVc{
    
}
