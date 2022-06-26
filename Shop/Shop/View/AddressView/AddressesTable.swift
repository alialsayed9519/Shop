//
//  AddressesTable.swift
//  Shop
//
//  Created by yasmeen hosny on 6/7/22.
//

import UIKit

class AddressesTable: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var lable: UILabel!
    
    var addresses = [Address]()
    var addressViewModel = AddressViewModel()
    let addAddressView = AddAddress()
    var order: Order?
    var chooseAddressFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(cell: AddressCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addressViewModel.fetchAddresses()
        addressViewModel.bindAddresses = self.bindAddresses
        addressViewModel.bindError = self.bindError
        self.tableView.reloadData()
        self.setupUI()
    }
    
    func bindAddresses(){
        addresses = addressViewModel.addresses ?? []
        self.tableView.reloadData()
    }
    
    func bindError() {
        let message = addressViewModel.error
        showAlert(title: "Error", message: message!, view: self)
    }

    @IBAction func addNewAddress(_ sender: Any) {
        addAddressView.editFlag = false
        addAddressView.chooseAddressFlag = self.chooseAddressFlag
        addAddressView.order = self.order
        self.navigationController?.pushViewController(addAddressView, animated: true)
    }
    
    //MARK: - set up UI
    private func setupUI(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Addresses"
        button.layer.cornerRadius = button.layer.frame.height / 2
        if chooseAddressFlag {
            if addresses.count == 0 {
                button.isHidden = false
            }
            else{
                button.isHidden = true
            }
        }
        else{
            lable.isHidden = true
        }
    }
    
    private func showDeleteAlert(addressId: Int){
        let alert = UIAlertController(title: "Delete Address", message: "Are you sour you want to delete this address", preferredStyle: .alert)
        let cancel  = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
        }
        let delete = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            self.addressViewModel.deleteAddress(addressId: addressId)
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - table data source and delgate
extension AddressesTable: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueNib() as AddressCell
        let address = addresses[indexPath.row]
        cell.updateUI(address: address)
        cell.editButton = {
            self.addAddressView.editFlag = true
            self.addAddressView.editAddress = self.addresses[indexPath.row]
            self.navigationController?.pushViewController(self.addAddressView, animated: true)
        }
        cell.deleteButton = {
            self.showDeleteAlert(addressId: address.id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if chooseAddressFlag{
            let payment = PaymentVc()
            self.order?.pilling_address = addresses[indexPath.row]
            payment.order? = self.order!
            self.navigationController?.pushViewController(payment, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.showDeleteAlert(addressId: addresses[indexPath.row].id)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

