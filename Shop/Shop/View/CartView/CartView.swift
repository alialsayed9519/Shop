//
//  CartView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import UIKit
/*
protocol CartSelection {
    func addProductToCart(product : Pproduct, atindex : Int)
}
*/
class CartView: UIViewController {
    private let draftOrderViewModel = DraftOrderViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
   
    private let customerViewModel = CustomerViewModel()
    private var user: User? = nil
    
    var items = [LineItems]()
    
    @IBOutlet var checkoutButton: UIView!
    var order = Order()
/*
    func addProductToCart(product: Pproduct, atindex: Int) {
        items[atindex].quantity = product.quant
            calculateTotal()
        }

        func calculateTotal()
        {
            var total = 0.0
            for item in items{
             //   print("\(Int(item.price))     clacTotal  ")
                total += Double(item.quantity) * (Double(item.price) ?? 0.0)
            }
            totalPrice.text = "\(Int(total))"

        }
    */
    @IBAction func checkoutBoutton(_ sender: Any) {
        checkoutButton.layer.cornerRadius = 20
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
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
        for item in items{
            total += Double(item.quantity) * (Double(item.price) ?? 0.0)
        }
        totalPrice.text = "\(Int(total))"
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
       // items[indexPath.row].quantity = cell.count
        //print("d3d3      \(items[indexPath.row].quantity)")
        cell.updateUI(item: item)
       // cell.cartSelectionDelegate = self

        return cell
    }
}
