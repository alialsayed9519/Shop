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
    var defaults:userDefaultsprotocol=userDefault()
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    private let customerViewModel = CustomerViewModel()
    private var user: User? = nil
     var totalPrice:String?
    @IBOutlet weak var imageControl: UIPageControl!
    private let draftOrderViewModel = DraftOrderViewModel()
    
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
        ratingCosmos.settings.updateOnTouch = false
        let backItem = UIBarButtonItem()
            backItem.title = "Category"
        addToBag.layer.cornerRadius = 20
        
        let nibCell = UINib(nibName: productImageCell, bundle: nil)
        productImageCollectionView.register(nibCell, forCellWithReuseIdentifier: productImageCell)
        // Do any additional setup after loading the view.
    }
    func displayProduct(){
        navigationItem.title=product?.vendor
        //title=product?.vendor
        reviewTextView.text=product?.product_type
        descTextView.text=product?.body_html
       var p=product?.variants![0].price
        setPrice(price: &p!)
        //priceLabel.text=product?.variants![0].price
        ratingCosmos.rating=ratings.randomElement()!
        
        
    }
    func setPrice(price: inout String){
        let currency=defaults.getCurrency(key: "currency")
        if currency=="USD" {
            let m="\((Double(price)!)*18)"
            print (m)
           price="\(m)"+" "+"USD"
        }
        else if currency=="EGP"{
            price=price+" "+"EGP"
        }
        priceLabel.text=price
    }
    override func viewWillAppear(_ animated: Bool) {
        print("\(userDefault().getId())     user id")
        customerViewModel.getCustomerwith(id: String(userDefault().getId()))
        customerViewModel.bindUser = { self.onSuccessUpdateView() }
    }
    
   
    func onSuccessUpdateView() {
        user = customerViewModel.customer
    }

    @IBAction func addToCart(_ sender: Any) {
        let userDefault: userDefaultsprotocol = userDefault()
        print("\(String(describing: user?.customer.note))     user?.customer.note    addToCart ")
        if userDefault.isLoggedIn() {
            if user?.customer.note == "0" {
                print("addToCart post")
                let firstProduct = Api(draft_order: Sendd(line_items: [OrderItem(variant_id: (product?.variants![0].id)!, quantity: 1)], customer: customer(id: userDefault.getId(), default_address: nil)))
                draftOrderViewModel.postNewDraftOrderWith(order: firstProduct, lastName: (user?.customer.last_name)!)
           
            } else {
                //print(userDefault.getId())
                print("addToCart modify")
            //    print(user?.customer.note)
                draftOrderViewModel.updateAnExistingDraftOrder(id: (user?.customer.note)!, variantId: (product?.variants![0].id)!)
                draftOrderViewModel.bindDraftViewModelErrorToView = { showAlert(title: "Message", message: self.draftOrderViewModel.showMassage!, view: self) }
            }
            
        } else {
            print(userDefault.isLoggedIn())
            let alert = UIAlertController(title: "Error", message: "Guest can't add to cart please login first", preferredStyle: .alert)
            let loginAction  = UIAlertAction(title: "go to login ", style: .default) { (UIAlertAction) in
                let login = loginvc()
               // login.homeFlag = false
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            let okAction  = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
            }
            alert.addAction(okAction)
            alert.addAction(loginAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    

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
