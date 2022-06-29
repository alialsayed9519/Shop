//
//  EntryVc.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit
import SwiftUI

class EntryVc: UIViewController {

    @IBOutlet weak var skip: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var entryImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(userDefault().getId())
        print(userDefault().getUserName())
        print(userDefault().getDraftOrder())
        print(userDefault().isLoggedIn())
        
        entryImage.image=UIImage(named: "shop")
        
        login.layer.cornerRadius=20
        skip.layer.cornerRadius=20
        // Do any additional setup after loading the view.
    }


    
    @IBAction func goToLogin(_ sender: Any) {
        print("goToLogin")
        self.navigationController?.pushViewController(loginvc(), animated: true)
    }
    
    @IBAction func goToHome(_ sender: Any) {
        let home = MyTabBar(nibName: "MyTabBar", bundle: nil)
        self.navigationController?.pushViewController(home, animated: true)
    }

}
