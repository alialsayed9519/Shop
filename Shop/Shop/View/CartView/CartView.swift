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
    
    var items = [LineItem]()
    var defaults:userDefaultsprotocol=userDefault()
    @IBOutlet var checkoutButton: UIView!
    var order = Order()

    @IBAction func checkoutBoutton(_ sender: Any) {
        if items.count != 0{
            if  userDefault().isLoggedIn(){
                if order.pilling_address == nil{
                    let addressTable = AddressesTable()
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
            let okAction = UIAlertAction(title: "Back to shopp", style: .default) { (action) in
              //  self.navigationController?.pushViewController(HomeVc(), animated: true)
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(items.count)
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Cart"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cell: CartItem.self)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(userDefault().getId())        cartView")
        customerViewModel.getCustomerwith(id: String(userDefault().getId()))
        customerViewModel.bindUser = { self.getUserSuccess() }
    }
    
    func getUserSuccess() {
        user = customerViewModel.customer
        print("\(String(describing: user?.customer.note))          getUserSuccess")
        if user?.customer.note != "0" && userDefault().isLoggedIn() {
            print("\((user?.customer.note)!)     getUserSuccess     ")
            userDefault().setDraftOrder(note: (user?.customer.note)!)
            draftOrderViewModel.getDraftOrderLineItems(id: (user?.customer.note)!)
            draftOrderViewModel.bindDraftOrderLineItemsViewModelToView = { self.onSuccessUpdateView() }
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
        let alert = UIAlertController(title: "Error", message: draftOrderViewModel.showError, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func clacTotal() {
        print("clacTotal")
        var total = 0.0
        var totalpr=""
        for item in items{
            total += Double(item.quantity) * (Double(item.price) ?? 0.0)
            let currency=defaults.getCurrency(key: "currency")
            if currency=="USD" {
               totalpr="\(total)"+" "+"USD"
            }
            else if currency=="EGP"{
                let m="\((total)*18)"
               totalpr="\(m)"+" "+"EGP"
            }
            
        }

        totalPrice.text = totalpr
    }
    
    
    func setPrice(price: inout String){
        let currency=defaults.getCurrency(key: "currency")
        if currency=="USD" {
           price=price+" "+"USD"
        }
        else if currency=="EGP"{
            let m="\((Double(price)!)*18)"
           price="\(m)"+" "+"EGP"
        }
        totalPrice.text=price
    }

}

extension CartView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueNib() as CartItem
        let item = items[indexPath.row]
        
        cell.itemCounter.text = String(items[indexPath.row].quantity )
        cell.buttonIncrease = { (cell) in
            self.items[indexPath.row].quantity += 1
            self.tableView.reloadData()
            self.clacTotal()
        }
        cell.buttonDecrease = { (cell) in
            if self.items[indexPath.row].quantity > 1 {
                self.items[indexPath.row].quantity -= 1
                self.tableView.reloadData()
                self.clacTotal()
            }
        }
        
        cell.updateUI(item: item)

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            self.clacTotal()
            if items.count > 1 {
                var newItems: [OrderItem] = []
                for item in items {
                    newItems.append(OrderItem(variant_id: item.variant_id, quantity: item.quantity))
                }
                draftOrderViewModel.updateAnExistingDraftOrder(id: (user?.customer.note)!, items: newItems)
            } else {
                draftOrderViewModel.deleteAnExistingDraftOrder(id: (user?.customer.note)!)
             //   noItemsInCart.isHidden = true
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row].quantity)
    }
    
}
