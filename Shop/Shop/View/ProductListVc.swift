//
//  ProductListVc.swift
//  Shop
//
//  Created by Salma on 19/06/2022.
//

import UIKit

class ProductListVc: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var products = [Product]()
    var searchedProduct=[Product]()
    private var mainCategories = [CustomCollection]()

    private let shopViewModel = ShopingViewModel()
var searching=false
    let searchController=UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "CatagoryCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "CatagoryCollectionViewCell")
        //shopViewModel.fetchCustomCollection()
        shopViewModel.fetchAllProducts()
        shopViewModel.bindProducts=self.bindProducts
        
setSearchController()
        // Do any additional setup after loading the view.
    }
    func bindProducts(){
        products = shopViewModel.allProduct ?? []
        self.collectionView.reloadData()
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductListVc: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchResultsUpdating,UISearchBarDelegate {
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
        
     //   cell.favProductBtn.tag = indexPath.row
     //   cell.favProductBtn.addTarget(self, action: #selector(addProductToFav), for: .touchUpInside)
        
        

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
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width - 30 )/3
            return CGSize(width: side, height: side)
        }

    }
