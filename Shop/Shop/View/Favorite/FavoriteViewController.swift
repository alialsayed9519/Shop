//
//  FavoriteViewController.swift
//  Shop
//
//  Created by Ali on 01/06/2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var items = [LineItem]()
    private let draftOrderViewModel = DraftOrderViewModel()
    private let customerViewModel = CustomerViewModel()
    private var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Favorite"
        
        let nibCell = UINib(nibName: "CatagoryCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "CatagoryCollectionViewCell")

        print("\(userDefault().getId())     user id")
        customerViewModel.getCustomerwith(id: String(userDefault().getId()))
        customerViewModel.bindUser = { self.onSuccessUpdateView() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func onSuccessUpdateView() {
        user = customerViewModel.customer
        if user?.customer.last_name != "0" {
            draftOrderViewModel.getDraftOrderLineItems(id: (user?.customer.last_name)!)
            draftOrderViewModel.bindDraftOrderLineItemsViewModelToView = { self.BindData() }
        }
    }
    
    func BindData(){
        items = draftOrderViewModel.lineItems ?? []
        self.collectionView.reloadData()
    }
    
}

// MARK: CollectionView Methods
extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCollectionViewCell", for: indexPath) as! CatagoryCollectionViewCell
        
        cell.favProductBtn.tag = indexPath.row
        cell.favProductBtn.addTarget(self, action: #selector(deleteProductFromFav), for: .touchUpInside)
        
        let product = items[indexPath.row]
        cell.updateFavoriteUI(item: product)
                
        return cell
    }
    
    @objc func deleteProductFromFav(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if items.count > 1 {
            var newItems: [OrderItem] = []
            for index in 0..<items.count {
                if indexPath.row == index { continue }
                newItems.append(OrderItem(variant_id: items[index].variant_id, quantity: items[index].quantity))
            }
            draftOrderViewModel.updateAnExistingDraftOrder(id: (user?.customer.last_name)!, items: newItems)

        } else {
            draftOrderViewModel.deleteAnExistingDraftOrder(id: (user?.customer.last_name)!,flag: false ,note: (user?.customer.note)!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width-10)/2
            let height = view.frame.size.height / 4
            return CGSize(width: side, height: height)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}


