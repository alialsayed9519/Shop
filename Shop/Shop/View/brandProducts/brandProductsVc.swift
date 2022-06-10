//
//  brandProductsVc.swift
//  Shop
//
//  Created by Salma on 10/06/2022.
//

import UIKit

class brandProductsVc: UIViewController {
    @IBOutlet weak var brandImg: UIImageView!
    let productCell="productCell"
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let brandProductCell=UINib(nibName:productCell , bundle: nil)
                productCollectionView.register(brandProductCell, forCellWithReuseIdentifier:productCell)
        // Do any additional setup after loading the view.
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
        return proCell
    }
}
