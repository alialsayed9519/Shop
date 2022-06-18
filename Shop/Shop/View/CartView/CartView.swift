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
    
    
    @IBAction func checkoutBoutton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Cart"
        tableView.dataSource = self
        tableView.delegate = self  
        tableView.registerNib(cell: CartItem.self)
        
    //  draftOrderViewModel.deleteAnExistingDraftOrder()
        
        
        draftOrderViewModel.getDraftOrderLineItems()
        draftOrderViewModel.bindDraftOrderLineItemsViewModelToView = { self.onSuccessUpdateView() }
        draftOrderViewModel.bindDraftViewModelErrorToView = { self.onFailUpdateView() }

    }
    
    func onSuccessUpdateView() {
        items = draftOrderViewModel.lineItems ?? []
        print("aaaaaaa")
        self.tableView.reloadData()
    }
    
    func onFailUpdateView() {
        let alert = UIAlertController(title: "Error", message: draftOrderViewModel.showError, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
    
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CartView: UITableViewDelegate{
    
}

extension CartView: UITableViewDataSource{
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
