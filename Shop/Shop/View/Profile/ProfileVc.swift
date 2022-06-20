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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: profileTableViewCellId, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: profileTableViewCellId)
    }
    func setUserData(){
            let name=userdefaults.getUserName()
            userName.text=name
        }
        func showAlertSheet(title:String, message:String,complition:@escaping (Bool)->Void){
            let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let logOut = UIAlertAction(title: "Log out", style: .destructive) { _ in
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
                        self.navigationController?.pushViewController(home, animated: true)
                        print(self.userdefaults.isLoggedIn())
                    }
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
            case 1:
                cell.image1.image = UIImage(named: "heart")
                cell.name.text = "My Wishlist"
            default:
                cell.image1.image = UIImage(named: "address")
                cell.name.text = "Address"
            }
            
        default:
                cell.image1.image = UIImage(named: "aboutUs")
                cell.name.text = "About us"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
   /*
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print("order")
            case 1:
                print("whislist")
            default:
                self.navigationController?.pushViewController(AddressesTable(), animated: true)
            }
            
        default:
            print("about us")
        }
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print("order")
            case 1:
                print("whislist")
            default:
                self.navigationController?.pushViewController(AddressesTable(), animated: true)
            }
            
        default:
            print("about us")
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
