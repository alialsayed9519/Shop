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
            self.addressViewModel.deleteAddress(addressId: address.id)
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
}

