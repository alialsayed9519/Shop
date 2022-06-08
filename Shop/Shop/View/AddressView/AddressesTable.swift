//
//  AddressesTable.swift
//  Shop
//
//  Created by yasmeen hosny on 6/7/22.
//

import UIKit

protocol NavigationHelper {
    func editAddrss()
}

class AddressesTable: UIViewController, NavigationHelper{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    var addresses = [Address]()
    var addressViewModel = AddressViewModel()
    let addressCell = AddressCell()
    let addAddressView = AddAddress()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        button.layer.cornerRadius = 20
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cell: AddressCell.self)
        
        
        addressCell.delegate = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Addresses"
        
        addressViewModel.bindAddresses = self.bindAddresses
        addressViewModel.bindError = self.bindError
        addressViewModel.fetchAddresses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func bindAddresses(){
        addresses = addressViewModel.addresses ?? []
        self.tableView.reloadData()
    }
    
    func bindError() {
        let message = addressViewModel.error
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("alert working")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func addNewAddress(_ sender: Any) {
        addAddressView.editFlag = false
        self.navigationController?.pushViewController(addAddressView, animated: true)
    }
    
    //MARK: navigation portocol
    func editAddrss() {
        addAddressView.editFlag = true
        self.navigationController?.pushViewController(addAddressView, animated: true)
    }
}

//MARK: table data source and delgate
extension AddressesTable: UITableViewDataSource, UITableViewDelegate{
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

