//
//  AddressesTable.swift
//  Shop
//
//  Created by yasmeen hosny on 6/7/22.
//

import UIKit

class AddressesTable: UIViewController, NavigationHelper{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    var addresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button.layer.cornerRadius = 20
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cell: AddressCell.self)
        let addressCell = AddressCell()
        addressCell.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Addresses"
    }
    
    
    @IBAction func addNewAddress(_ sender: Any) {
        let addAddressView = AddAddress()
        addAddressView.editFlag = false
        self.navigationController?.pushViewController(addAddressView, animated: true)
    }
    
    func editAddrss() {
        let addAddressView = AddAddress()
        addAddressView.editFlag = true
        self.navigationController?.pushViewController(addAddressView, animated: true)
    }

}

extension AddressesTable: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueNib() as AddressCell
        let address = addresses[indexPath.row]
        cell.updateUI(address: address)
        return cell
    }
    
    
}

extension AddressesTable: UITableViewDelegate{
    
}

protocol NavigationHelper {
    func editAddrss()
}
