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
    
    var items = [Product]()
    
    
    @IBAction func checkoutBoutton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
