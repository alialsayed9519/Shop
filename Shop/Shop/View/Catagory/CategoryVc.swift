//
//  CategoryVc.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit
import JJFloatingActionButton

class CategoryVc: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UIToolbar!
    @IBOutlet private weak var internetImage: UIImageView!
var searching=false
    var actionButton = JJFloatingActionButton()
    private let favoriteViewModel = FavoriteViewModel()
    private var products = [Product]()
    var searchedProduct=[Product]()
    private var mainCategories = [CustomCollection]()
    
    private let shopViewModel = ShopingViewModel()
    
    private var mainCategoryIndex = 0
    private var subCategoryName: String?
    let searchController=UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        // Do any additional setup after loading the view.
        
        let nibCell = UINib(nibName: "CatagoryCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "CatagoryCollectionViewCell")
        createFAB()
        
        shopViewModel.fetchCustomCollection()
        shopViewModel.bindCategorys = onCategoriesSuccess
        shopViewModel.bindProducts = onProductsSuccess

    }
    
    func setSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        searchController.obscuresBackgroundDuringPresentation=false
        searchController.searchBar.enablesReturnKeyAutomatically=false
        searchController.searchBar.returnKeyType=UIReturnKeyType.done
        self.navigationItem.hidesSearchBarWhenScrolling=false
        self.navigationItem.searchController=searchController
        definesPresentationContext=true
        searchController.searchBar.placeholder="search product By Name"
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.reloadData()
        if ReachabilityViewModel.isConnected() {
            internetImage.isHidden = true
        }
    }
    
    @IBAction func tabItemSelected(_ sender: UIBarButtonItem) {
        self.mainCategoryIndex = sender.tag
        shopViewModel.filterPorductsByMainCategory(itemIndex: mainCategoryIndex)
    }
    
    @IBAction func search(_ sender: Any) {
        self.navigationController?.pushViewController(ProductListVc(), animated: true)
    }
    @IBAction func navigateToCart(_ sender: Any) {
        self.navigationController?.pushViewController(CartView(), animated: true)
    }
    
    @IBAction func navigateToFavorite(_ sender: Any) {
        self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }
    
    
}

// MARK: CollectionView Methods
extension CategoryVc: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchResultsUpdating,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText=searchController.searchBar.text!
        if !searchText.isEmpty{
            searching=true
            searchedProduct.removeAll()
            for product in products{
                if product.title.lowercased().contains(searchText.lowercased()){
                    searchedProduct.append(product)
                }
            }
            
        }
        else{
            searching=false
            searchedProduct.removeAll()
            searchedProduct=products
            
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching=false
        searchedProduct.removeAll()
        collectionView.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return searchedProduct.count
        }
        else{
      return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCollectionViewCell", for: indexPath) as! CatagoryCollectionViewCell
        
        cell.favProductBtn.tag = indexPath.row
        cell.favProductBtn.addTarget(self, action: #selector(addProductToFav), for: .touchUpInside)
        
        

        if searching{
            let searchedProducts=searchedProduct[indexPath.row]
            cell.updateUI(product:searchedProducts)
        }
        else{
            let product = products[indexPath.row]
            cell.updateUI(product: product)
            
        }
        return cell
    }
    
    @objc func addProductToFav(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        favoriteViewModel.addProductToFavorite(product: products[index.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width-10)/2
            let height = view.frame.size.height / 4
            return CGSize(width: side, height: height)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        print("\(String(describing: product.title)) in index  \(indexPath.row + 1)")
        let vc = ProductDetailsVc()
        vc.product=product
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: On Success Methods
extension CategoryVc{
    
    func onCategoriesSuccess(){
        guard let categories = shopViewModel.categorys else{
            return
        }
        self.mainCategories = categories
        shopViewModel.filterPorductsByMainCategory(itemIndex: mainCategoryIndex)
    }
    
    func onProductsSuccess(){
        guard  let products = shopViewModel.allProduct else {
            print("there are no proucts yet")
            return
        }
        self.products = products
        if let productType = subCategoryName {
            shopViewModel.filterPorductsBySubCategory(subCategoryName: productType)
        }
        self.collectionView.reloadData()
    }
}

// MARK: FAB
extension CategoryVc{
    func createFAB(){
        
        actionButton.addItem(title: "shoes", image: UIImage(named: "shoes")?.withRenderingMode(.alwaysOriginal)) { item in
            self.actionButton.buttonImage = UIImage(named: "shoes")
            self.subCategoryName = "SHOES"
            self.shopViewModel.filterPorductsBySubCategory(subCategoryName: self.subCategoryName!)
        }

        actionButton.addItem(title: "T-Shirts", image: UIImage(named: "t-shirt")?.withRenderingMode(.alwaysOriginal)) { item in
            self.actionButton.buttonImage = UIImage(named: "t-shirt")
            self.subCategoryName = "T-SHIRTS"
            self.shopViewModel.filterPorductsBySubCategory(subCategoryName: self.subCategoryName!)
        }

        actionButton.addItem(title: "Accessres", image: UIImage(named: "accessres")?.withRenderingMode(.alwaysOriginal)) { item in
            self.actionButton.buttonImage = UIImage(named: "accessres")
            self.subCategoryName = "ACCESSRES"
            self.shopViewModel.filterPorductsBySubCategory(subCategoryName: self.subCategoryName!)
        }
        
        actionButton.display(inViewController: self)
        customizFAB()
    }
    func customizFAB(){
        actionButton.handleSingleActionDirectly = true
        actionButton.buttonDiameter = 90
        actionButton.overlayView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        actionButton.buttonImage = UIImage(named: "filter")
        actionButton.buttonColor = .white
        actionButton.buttonImageColor = .white
        actionButton.buttonImageSize = CGSize(width: 65, height: 65)

       // actionButton.buttonAnimationConfiguration = .transition(toImage: UIImage(named: "X"))
        actionButton.itemAnimationConfiguration = .slideIn(withInterItemSpacing: 14)

        actionButton.layer.shadowColor = UIColor.black.cgColor
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        actionButton.layer.shadowOpacity = Float(0.4)
        actionButton.layer.shadowRadius = CGFloat(2)

        actionButton.itemSizeRatio = CGFloat(0.75)
        actionButton.configureDefaultItem { item in
            item.titlePosition = .leading

            item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            item.titleLabel.textColor = .white
            item.buttonColor = .white
            item.buttonImageColor = .white

            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOffset = CGSize(width: 0, height: 1)
            item.layer.shadowOpacity = Float(0.4)
            item.layer.shadowRadius = CGFloat(2)
        }
    }

}