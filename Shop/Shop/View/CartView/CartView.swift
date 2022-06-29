//
//  CartView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import UIKit

class CartView: UIViewController {
    private let draftOrderViewModel = DraftOrderViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var noItemsInCart: UILabel!
    private let customerViewModel = CustomerViewModel()
    private var user: User? = nil
    var defaults:userDefaultsprotocol=userDefault()
    var items = [LineItem]()
    
    @IBOutlet var checkoutButton: UIView!
    var order = Order()

    @IBAction func checkoutBoutton(_ sender: Any) {
        if items.count != 0{
            if  userDefault().isLoggedIn(){
                if order.pilling_address == nil{
                    let addressTable = AddressesTable()
                    addressTable.order = self.order
                    addressTable.chooseAddressFlag = true
                    self.navigationController?.pushViewController(addressTable, animated: true)
                }
                else {
                    order.line_items = self.items
                    order.current_total_price = totalPrice.text
                    let paymentVc = PaymentVc()
                    paymentVc.order = self.order
                    self.navigationController?.pushViewController(paymentVc, animated: true)
                }
            }
            else{
                let login = loginvc()
                login.homeFlag = false
                self.navigationController?.pushViewController(login, animated: true)
            }
        }
        else{
            let alert = UIAlertController(title: "Empty Cart", message: "There is no items in your cart", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Continue shopping", style: .default) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(items.count)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cell: CartItem.self)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Cart"
        customerViewModel.getCustomerwith(id: String(userDefault().getId()))
        customerViewModel.bindUser = { self.getUserSuccess() }
    }
    
    func getUserSuccess() {
        user = customerViewModel.customer
        if user?.customer.note != "0" && userDefault().isLoggedIn() {            userDefault().setDraftOrder(note: (user?.customer.note)!)
            draftOrderViewModel.getDraftOrderLineItems(id: (user?.customer.note)!)
            draftOrderViewModel.bindDraftOrderLineItemsViewModelToView = { self.onSuccessUpdateView()
                
            }
            draftOrderViewModel.bindDraftViewModelErrorToView = { self.onFailUpdateView() }
        }
    }
    
    fileprivate func updateDraftOrderBeforeNavigate() {
        var newItems: [OrderItem] = []
        for item in items {
            newItems.append(OrderItem(variant_id: item.variant_id, quantity: item.quantity))
        }
        draftOrderViewModel.updateAnExistingDraftOrder(id: (user?.customer.note)!, items: newItems)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !items.isEmpty {
            updateDraftOrderBeforeNavigate()
        }
    }
    
    func onSuccessUpdateView() {
        items = draftOrderViewModel.lineItems ?? []
        self.tableView.reloadData()
        self.clacTotal()
        
        
    }
    
    func onFailUpdateView() {
        let message = draftOrderViewModel.showError
        showAlert(title: "Error", message: message!, view: self)
    }
    
//
    ///////////////////////////
    func clacTotal() {
        print("clacTotal")
        var total = 0.0
        var totalpr=0.0
        for item in items{
            total += Double(item.quantity) * (Double(item.price) ?? 0.0)
            let currency=defaults.getCurrency(key: "currency")
            if currency=="USD" {
               totalpr=total
            }
            else if currency=="EGP"{
                
               totalpr=total*18
            }
            
        }

        totalPrice.text = "\(totalpr)"
    }
    //////////////////////////
 

}

extension CartView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueNib() as CartItem
        let item = items[indexPath.row]
        cell.updateUI(item: item)
        self.items[indexPath.row].maxQuantity = cell.number
        print("\(String(describing: cell.number))              ;;;;;;;")
       // cell.itemCounter.text = String(items[indexPath.row].quantity )
        var count =  self.items[indexPath.row].quantity
        
        cell.buttonIncrease = {
            if count <= self.items[indexPath.row].maxQuantity ?? 2 {
                count += 1
                cell.itemCounter.text = String(count)
                self.items[indexPath.row].quantity = count
                self.clacTotal()
            } else {
                let alert = UIAlertController(title: "message", message: "this is the max Quantity ", preferredStyle: .alert)
                let okAction  = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        cell.buttonDecrease = {
            if self.items[indexPath.row].quantity > 1 {
                count -= 1
                cell.itemCounter.text = String(count)
                self.items[indexPath.row].quantity = count
                self.clacTotal()
            }
        }
        
        cell.deleteItem.tag = indexPath.row
        cell.deleteItem.addTarget(self, action: #selector(deleteItemFromCart), for: .touchUpInside)

        return cell
    }
    
    @objc func deleteItemFromCart(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        items.remove(at: index.row)
        tableView.deleteRows(at: [index], with: .fade)
        tableView.reloadData()
        self.clacTotal()
        if items.count >= 1 {
            var newItems: [OrderItem] = []
            for item in items {
                newItems.append(OrderItem(variant_id: item.variant_id, quantity: item.quantity))
            }
            draftOrderViewModel.updateAnExistingDraftOrder(id: (user?.customer.note)!, items: newItems)
        } else {
            print("else")
            draftOrderViewModel.deleteAnExistingDraftOrder(id: (user?.customer.note)!, lastName: (user?.customer.last_name)!)
         //   noItemsInCart.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            self.clacTotal()
            if items.count >= 1 {
                var newItems: [OrderItem] = []
                for item in items {
                    newItems.append(OrderItem(variant_id: item.variant_id, quantity: item.quantity))
                }
                draftOrderViewModel.updateAnExistingDraftOrder(id: (user?.customer.note)!, items: newItems)
            } else {
                draftOrderViewModel.deleteAnExistingDraftOrder(id: (user?.customer.note)!, lastName: (user?.customer.last_name)!)
             //   noItemsInCart.isHidden = true
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
