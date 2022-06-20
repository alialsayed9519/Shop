//
//  CartView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import UIKit

class CartView: UIViewController{
    private let draftOrderViewModel = DraftOrderViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    var items = [LineItems]()
    
    @IBOutlet var checkoutButton: UIView!
    var order: Order?

    
    @IBAction func checkoutBoutton(_ sender: Any) {

        if (items.count == 0){
            if userDefault().isLoggedIn() {
                if order?.pilling_address == nil{
                    let addressTable = AddressesTable()
                    addressTable.chooseAddressFlag = true
                    self.navigationController?.pushViewController(addressTable, animated: true)
                }else{
                    order?.line_items = self.items
                    order?.current_total_price = totalPrice.text
                    let paymentVc = PaymentVc()
                    paymentVc.order = self.order
                    self.navigationController?.pushViewController(paymentVc, animated: true)
                }
            }else{
                let login = loginvc()
                login.homeFlag = false
                self.navigationController?.pushViewController(login, animated: true)

        } else {
            let alert = UIAlertController(title: "Empty Cart", message: "There is no items in your cart", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Back to shopp", style: .default) { (action) in
                self.navigationController?.pushViewController(HomeVc(), animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Cart"
        tableView.dataSource = self
        tableView.delegate = self  
        tableView.registerNib(cell: CartItem.self)
        draftOrderViewModel.getDraftOrderLineItems()
        draftOrderViewModel.bindDraftOrderLineItemsViewModelToView = { self.onSuccessUpdateView() }
        draftOrderViewModel.bindDraftViewModelErrorToView = { self.onFailUpdateView() }
    }
    
    func onSuccessUpdateView() {
        items = draftOrderViewModel.lineItems ?? []
        self.clacTotal()
        self.tableView.reloadData()
    }
    
    func onFailUpdateView() {
        let alert = UIAlertController(title: "Error", message: draftOrderViewModel.showError, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func clacTotal() {
        var total = 0
        for item in items{
            total += item.quantity * Int(item.price)!
        }
        totalPrice.text = "\(total)"
    }

}

extension CartView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueNib() as CartItem
        let item = items[indexPath.row]
        cell.updateUI(item: item)
        return cell
    }
}
