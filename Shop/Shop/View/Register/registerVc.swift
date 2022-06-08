//
//  registerVc.swift
//  Shop
//
//  Created by Salma on 29/05/2022.
//

import UIKit
import TextFieldEffects
class registerVc: UIViewController {
    var first_name,last_name,email,password:String!
    var registerViewModel:regTemp=RegisterViewModel()
    @IBOutlet weak var regImg: UIImageView!
    
    @IBOutlet weak var regiBtn: UIButton!
    @IBOutlet weak var logBtn: UIButton!
    @IBOutlet weak var passTf: HoshiTextField!
    @IBOutlet weak var emailTf: HoshiTextField!
    @IBOutlet weak var lnameTf: HoshiTextField!
    @IBOutlet weak var fnameTf: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       // regiBtn.backgroundColor =.green
        regiBtn.layer.cornerRadius=20
        regImg.image=UIImage(named: "shop")
        // Do any additional setup after loading the view.
    }



    @IBAction func loginBtn(_ sender: Any) {
        self.navigationController?.pushViewController(loginvc(), animated: true)
    }
    
     @IBAction func regisBtn(_ sender: Any) {
         first_name=fnameTf.text ?? ""
         last_name=lnameTf.text ?? ""
         email=emailTf.text ?? ""
         password=passTf.text ?? ""
         registerViewModel.register(firstName: first_name, lastName: last_name, email: email, password: password)
         
         self.navigationController?.pushViewController(HomeVc(), animated: true)
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
