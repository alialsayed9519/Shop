//
//  HomeVc.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit

class HomeVc: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let brandsCollectionViewCellId = "BrandsCollectionViewCell"
    private var brands: [Brand] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        let nibCell = UINib(nibName: brandsCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: brandsCollectionViewCellId)

        for _ in 1...16 {
            let brand = Brand(name: "Adidas", image: "adidas")
            brands.append(brand)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.reloadData()
    }
}

extension HomeVc: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brandsCollectionViewCellId, for: indexPath) as! BrandsCollectionViewCell
        let brand = brands[indexPath.row]
        cell.updateUI(brand: brand)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width - 30 )/2
            return CGSize(width: side, height: side)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brand = brands[indexPath.row]
        print("\(brand.name) in index  \(indexPath.row + 1)")
    }
}
