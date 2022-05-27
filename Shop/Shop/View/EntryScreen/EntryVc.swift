//
//  EntryVc.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit

class EntryVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        // Do any additional setup after loading the view.
    }


    
    @IBAction func goToLogin(_ sender: Any) {
        print("goToLogin")
    }
    
    @IBAction func goToHome(_ sender: Any) {
        let home = MyTabBar(nibName: "MyTabBar", bundle: nil)
        //self.navigationController?.pushViewController(home, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? HomeVc
    }

}
