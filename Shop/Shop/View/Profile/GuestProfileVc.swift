//
//  GuestProfileVc.swift
//  Shop
//
//  Created by Salma on 18/06/2022.
//

import UIKit

class GuestProfileVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func goToLogin(_ sender: Any) {
        self.navigationController?.pushViewController(loginvc(), animated: true)
    }
    
    @IBAction func goToSignup(_ sender: Any) {
        self.navigationController?.pushViewController(registerVc(), animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
