//
//  loginvc.swift
//  Shop
//
//  Created by Salma on 29/05/2022.
//

import UIKit
import TextFieldEffects
class loginvc: UIViewController {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var loginImg: UIImageView!
    
    @IBOutlet weak var emailTf: HoshiTextField!
    
    @IBOutlet weak var passTf: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      //  signInBtn.backgroundColor =  .green
        signInBtn.layer.cornerRadius=20
        loginImg.image=UIImage(named: "shop")
        // Do any additional setup after loading the view.
    }


    @IBAction func signInBtn(_ sender: Any) {
        self.navigationController?.pushViewController(HomeVc(), animated: true)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
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
