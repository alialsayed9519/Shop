//
//  CartView.swift
//  Shop
//
//  Created by yasmeen hosny on 5/25/22.
//

import UIKit

class CartView: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet var checkoutButton: UIView!
    var items = [Product]()
    var orderAddress: Address?
    
    @IBAction func checkoutBoutton(_ sender: Any) {
        if userDefault().isLoggedIn() {
            if orderAddress == nil{
                let addressTable = AddressesTable()
                self.navigationController?.pushViewController(addressTable, animated: true)
            }else{
                let paymentVc = PaymentVc()
                paymentVc.orderAddress = self.orderAddress
                paymentVc.orderItems = self.items 
                self.navigationController?.pushViewController(paymentVc, animated: true)
            }
        }else{
            let login = loginvc()
            login.homeFlag = false
            self.navigationController?.pushViewController(login, animated: true)
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
    }
}

extension CartView: UITableViewDelegate{
    
}

extension CartView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueNib() as CartItem
        let item = items[indexPath.row]
        cell.updateUI(item: item)
        return cell
    }
}
