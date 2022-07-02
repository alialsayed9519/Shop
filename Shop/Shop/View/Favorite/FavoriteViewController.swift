//
//  FavoriteViewController.swift
//  Shop
//
//  Created by Ali on 01/06/2022.
//

import UIKit

class FavoriteViewController: UIViewController {   
    @IBOutlet weak var table: UITableView!
    private var items: [LineItem] = []
    private let draftOrderViewModel = DraftOrderViewModel()
    private let customerViewModel = CustomerViewModel()
    private var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.registerNib(cell: CartItem.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Favorite"
        customerViewModel.getCustomerwith(id: String(userDefault().getId()))
        customerViewModel.bindUser = { self.onSuccessUpdateView() }
    }
    
    func getUserSuccess() {
        user = customerViewModel.customer
        if user?.customer.last_name != "0" && userDefault().isLoggedIn() {            userDefault().setDraftOrder(note: (user?.customer.note)!)
            draftOrderViewModel.getDraftOrderLineItems(id: (user?.customer.last_name)!)
            draftOrderViewModel.bindDraftOrderLineItemsViewModelToView = {
                self.onSuccessUpdateView()
            }
        }
    }
    
    func onSuccessUpdateView() {
        user = customerViewModel.customer
        if user?.customer.last_name != "0" {
            draftOrderViewModel.getDraftOrderLineItems(id: (user?.customer.last_name)!)
            draftOrderViewModel.bindDraftOrderLineItemsViewModelToView = { self.BindData() }
        }
    }
    
    func BindData() {
        items = draftOrderViewModel.lineItems ?? []
        self.table.reloadData()
    }
    
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueNib() as CartItem
        let item = items[indexPath.row]
        
        cell.updateFav(item: item)
       
        cell.deleteItem.tag = indexPath.row
        cell.deleteItem.addTarget(self, action: #selector(deleteProductFromFav), for: .touchUpInside)

        return cell
    }
    
    @objc func deleteProductFromFav(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        items.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        table.reloadData()
        if items.count >= 1 {
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

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
            if items.count >= 1 {
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
    
    }
    
}
