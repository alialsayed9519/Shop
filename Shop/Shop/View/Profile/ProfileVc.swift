//
//  ProfileVc.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit

class ProfileVc: UIViewController {
    var userdefaults:userDefaultsprotocol=userDefault()
    @IBOutlet weak var userName: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private let profileTableViewCellId = "ProfileTableViewCell"
    var currencyViewMode = currencyViewModel()
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        let nibCell = UINib(nibName: profileTableViewCellId, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: profileTableViewCellId)
        setUserData()
                currencyViewMode.bindCurrencyViewModel=onSucess
    }
    func onSucess(){
      //  tableView.reloadData()

        
    }
    
    func setUserData(){
        let name = userdefaults.getUserName()
        userName.text = name!
    }
    
    func showCurrencyAlert(){
        let alert=UIAlertController(title: "choose currency", message: nil, preferredStyle: .alert)
        let egpAction=UIAlertAction(title: "EGP", style: .default){
            (UIAlertAction) in
            self.currencyViewMode.setCurrency(key: "currency", value: "EGP")

                    }
        let usdAction=UIAlertAction(title: "USD", style: .default){
            (UIAlertAction) in
            self.currencyViewMode.setCurrency(key: "currency", value: "USD")
        }
        alert.addAction(egpAction)
        alert.addAction(usdAction)
        self.present(alert, animated: true, completion: nil)
    }
        func showAlertSheet(title:String, message:String,complition:@escaping (Bool)->Void){
            let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let logOut = UIAlertAction(title: "Log Out", style: .destructive) { _ in
                complition(true)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
                complition(false)
            }
            actionSheet.addAction(logOut)
            actionSheet.addAction(cancel)
            self.present(actionSheet, animated: true, completion: nil)
        }

    @IBAction func logout(_ sender: Any) {
        showAlertSheet(title: "do you want to logout", message: "sorry to see you leave us 💔"){
                    sucess
                    in
                    if sucess{
                        self.userdefaults.logout()
                        //self.userdefaults.setId(id: nil)
                        let home = MyTabBar(nibName: "MyTabBar", bundle: nil)
                        self.navigationController?.pushViewController(home, animated: true)                    }
                }
        
    }
    

}

extension ProfileVc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileTableViewCellId, for: indexPath) as! ProfileTableViewCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.image1.image = UIImage(named: "shopping-bag")
                cell.name.text = "My Orders"
                cell.button.isHidden=true
            case 1:
                cell.image1.image = UIImage(named: "currency")
                cell.name.text = "currency"
                cell.button.isHidden=false
                
               //  currencyViewMode.getCurrency(key: "currency")=="USD"{
                    cell.button.setTitle(currencyViewMode.getCurrency(key: "currency"), for: .normal)
//                else if currencyViewMode.getCurrency(key: "currency")=="EGP"{
//                   // cell.button.setTitle(, for: .normal)
//
            default:
                cell.image1.image = UIImage(named: "address")
                cell.name.text = "Address"
                cell.button.isHidden=true
            }
            
        default:
                cell.image1.image = UIImage(named: "aboutUs")
                cell.name.text = "About us"
            cell.button.isHidden=true
        }
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(OrdersTable(), animated: true)
            case 1:
                showCurrencyAlert()
            default:
                self.navigationController?.pushViewController(AddressesTable(), animated: true)
            }
            
        default:
            self.navigationController?.pushViewController(AboutUs(), animated: true)
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "My Account"
        default:
            return "About"
        }
    }
    
}
