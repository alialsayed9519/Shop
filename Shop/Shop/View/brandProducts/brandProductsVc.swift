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
    @IBOutlet weak var brandImg: UIImageView!
    let productCell="productCell"
    var smartCol:SmartCollection?
    var product:Product!
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let brandProductCell=UINib(nibName:productCell , bundle: nil)
                productCollectionView.register(brandProductCell, forCellWithReuseIdentifier:productCell)
        
      brandImg.sd_setImage(with:URL(string:smartCol?.image
.src?),placeholderImage:UIImage(named:"adidas.png"))
        shopViewModel.filterBrandsByNmae(brandName:smartCol?.title!)
       // let imageView = SDAnimatedImageView()
        let animatedImage = SDAnimatedImage(named: (smartCol?.image.src)!)
        brandImg.image = animatedImage
        // Do any additional setup after loading the view.
    }

    func display(){
        
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

extension brandProductsVc:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let proCell=collectionView.dequeueReusableCell(withReuseIdentifier: productCell, for: indexPath) as! productCell
        proCell.productName.text=product.title
        proCell.productImg.sd_setImage(with: URL(string: product.images[0].src), placeholderImage: UIImage(named: "adidas"))
        return proCell
    }
}
