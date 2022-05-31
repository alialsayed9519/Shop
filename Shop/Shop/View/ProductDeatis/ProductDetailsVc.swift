//
//  ProductDetailsVc.swift
//  Shop
//
//  Created by Salma on 31/05/2022.
//

import UIKit
import Cosmos
class ProductDetailsVc: UIViewController {
    var product:Product!
    var ratings=[4,4.5,5]
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    
    @IBOutlet weak var imageControl: UIPageControl!
    
    
    @IBOutlet weak var reviewTextView: UITextView!
    
    @IBOutlet weak var ratingCosmos: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var addToBag: UIButton!
    let productImageCell="productImgCell"
    override func viewDidLoad() {
        super.viewDidLoad()
displayProduct()
        navigationItem.backBarButtonItem=UIBarButtonItem(
            title: "Category", style: .plain, target: nil, action: nil)
                addToBag.backgroundColor = .blue
        addToBag.layer.cornerRadius = 20
let productCell=UINib(nibName:productImageCell , bundle: nil)
        productImageCollectionView.register(productCell, forCellWithReuseIdentifier: productImageCell)
        
        // Do any additional setup after loading the view.
    }
    func displayProduct(){
        title=product.vendor
        reviewTextView.text=product.product_type
        descTextView.text=product.description
        priceLabel.text=product.variants![0].price
        ratingCosmos.rating=ratings.randomElement()!
        
        
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
extension ProductDetailsVc:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageControl.numberOfPages=product.images!.count
        return product.images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell=collectionView.dequeueReusableCell(withReuseIdentifier: productImageCell, for: indexPath) as! ProductImageCellCollectionViewCell
        imageCell.productImg.image=UIImage(named: product.images![indexPath.row].src!)
       
        return imageCell
    }
    
    
}
