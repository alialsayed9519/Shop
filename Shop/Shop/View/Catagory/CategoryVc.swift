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
    
    private let shopViewModel = ShopingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        collectionView.registerNib(cell: CatagoryCollectionViewCell.self)

        shopViewModel.fetchCustomCollection()
        shopViewModel.bindProducts = self.updateViewwithProducts
        shopViewModel.filterPorductsByMainCategory(itemIndex: 0, completion: updateViewwithProducts)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    @IBAction func tabItemSelected(_ sender: UIBarButtonItem) {
        shopViewModel.filterPorductsByMainCategory(itemIndex: sender.tag, completion: self.updateViewwithProducts)
    }
    
    @IBAction func navigateToCart(_ sender: Any) {
        self.navigationController?.pushViewController(CartView(), animated: true)
    }
    
    @IBAction func navigateToFavorite(_ sender: Any) {
        self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }
    
    
}

// MARK: CollectionView Methods
extension CategoryVc: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueNib(indexPath: indexPath) as! CatagoryCollectionViewCell
        let product = products[indexPath.row]
        cell.updateUI(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width - 30 )/3
            return CGSize(width: side, height: side)  
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        print("\(String(describing: product.title)) in index  \(indexPath.row + 1)")
    }
}

extension CategoryVc{
    
    func updateViewwithProducts(){
        guard  let products = shopViewModel.allProduct else {
            print("there are no proucts yet")
            return
        }
        self.products = products
    }
    
}
