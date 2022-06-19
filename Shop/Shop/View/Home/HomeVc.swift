//
//  HomeVc.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit

class HomeVc: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var internetImage: UIImageView!
    @IBOutlet private weak var addsImage: UIImageView!
    private let brandsCollectionViewCellId = "BrandsCollectionViewCell"
    private var brands: [SmartCollection] = []
    private var brandsViewModel = BrandsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        let nibCell = UINib(nibName: brandsCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: brandsCollectionViewCellId)
        
        showAddsImages()
        
        brandsViewModel.bindBrandsViewModelToView = { self.onSuccessUpdateView() }
        brandsViewModel.bindViewModelErrorToView = { self.onFailUpdateView() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if ReachabilityViewModel.isConnected() {
            internetImage.isHidden = true
        }
    }
    
    func showAddsImages() {
        let images = [UIImage(named: "addsOne"), UIImage(named: "addsTwo"), UIImage(named: "addsThree"), UIImage(named: "addsFour"), UIImage(named: "addsFive")].compactMap{$0} // ignore nil image
        addsImage.animationImages = images
        addsImage.animationDuration = 5
        addsImage.roundedImage()
        addsImage.startAnimating()
    }

    func onSuccessUpdateView() {
        brands = brandsViewModel.smartCollection ?? []
        self.collectionView.reloadData()
    }
    
    func onFailUpdateView() {
        let alert = UIAlertController(title: "Error", message: brandsViewModel.showError, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
    
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func navigateToCartScreen(_ sender: Any) {
        self.navigationController?.pushViewController(CartView(), animated: true)
    }
    
    @IBAction func navigateToFavoriteScreen(_ sender: Any) {
        self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
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
    //    let proVc=brandProductsVc()
       // proVc.smartCol=brand
      //  self.navigationController?.pushViewController(proVc, animated: true)
    }
}

