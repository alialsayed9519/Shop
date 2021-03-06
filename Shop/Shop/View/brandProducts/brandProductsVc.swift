//
//  brandProductsVc.swift
//  Shop
//
//  Created by Salma on 10/06/2022.
//

import UIKit
import SDWebImage
class brandProductsVc: UIViewController {
    private let shopViewModel = ShopingViewModel()
   
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var brandImg: UIImageView!
    
    @IBOutlet weak var navigationITitle: UINavigationItem!
    let productCell="CatagoryCollectionViewCell"
    var smartCol:SmartCollection!
    var custom:CustomCollection!
    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationITitle.title=smartCol.title
        let brandProductCell=UINib(nibName:productCell , bundle: nil)
                productCollectionView.register(brandProductCell, forCellWithReuseIdentifier:productCell)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setBrandImage()

        shopViewModel.fetchbrandProducts(collectionTitle: smartCol.title)
        shopViewModel.bindProducts=self.onSuccess
    
        // Do any additional setup after loading the view.
    }
    func setBrandImage(){
        brandImg.layer.cornerRadius=10
        brandImg.layer.borderWidth=4
        brandImg.layer.borderColor=UIColor.black.cgColor
       brandImg.sd_setImage(with:URL(string:smartCol.image.src), placeholderImage: UIImage(named: "adidas.png"))
    }
    func onSuccess() {
          guard let products = shopViewModel.allProduct
           else {
            return
        }
        self.products = products
        productCollectionView.reloadData()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension brandProductsVc:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let proCell=collectionView.dequeueReusableCell(withReuseIdentifier: productCell, for: indexPath) as! CatagoryCollectionViewCell
        let product = products[indexPath.row]
        proCell.updateUI(product: product)
        
//        proCell.productImg.sd_setImage(with: URL(string: (product?.images[0].src)!),placeholderImage: UIImage(named: "adidas"))
        return proCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let vc = ProductDetailsVc()
        vc.product=product
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let side = (view.frame.size.width-10)/2
                let height = view.frame.size.height / 4
                return CGSize(width: side, height: height)
            }
}
