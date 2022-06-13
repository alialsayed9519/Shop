//
//  ProductDetailsVc.swift
//  Shop
//
//  Created by Salma on 31/05/2022.
//

import UIKit
import Cosmos
import SDWebImage
class ProductDetailsVc: UIViewController {
    var product:Product!
    var ratings=[4,4.5,5]
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    
    @IBOutlet weak var imageControl: UIPageControl!
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var reviewTextView: UITextView!
    
    @IBOutlet weak var ratingCosmos: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var navigationtitle: UINavigationItem!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var addToBag: UIButton!
    let productImageCell="ImageCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
displayProduct()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let backItem = UIBarButtonItem()
            backItem.title = "Category"
       // navBar.ba = backItem;
        addToBag.backgroundColor = .blue
        addToBag.layer.cornerRadius = 20

        let nibCell = UINib(nibName: productImageCell, bundle: nil)
        productImageCollectionView.register(nibCell, forCellWithReuseIdentifier: productImageCell)
        // Do any additional setup after loading the view.
    }
    func displayProduct(){
      //  navigationtitle.title=product?.vendor
//        navigationtitle.backBarButtonItem
        navigationItem.title=product?.vendor
        //title=product?.vendor
        reviewTextView.text=product?.product_type
        descTextView.text=product?.body_html
        priceLabel.text=product?.variants![0].price
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
        imageControl.numberOfPages=product.images.count
        return product.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell=collectionView.dequeueReusableCell(withReuseIdentifier: productImageCell, for: indexPath) as! ImageCollectionViewCell
        
        let ImageSrc = product.images[indexPath.row].src
        print(ImageSrc)
        imageCell.proimageCell.sd_setImage(with: URL(string: ImageSrc), placeholderImage: UIImage(named: "adidas.png"))

      //  imageCell.productImg.sd_setImage(with: URL(string: ImageSrc), completed: nil)
        return imageCell
    }
    
    
}
