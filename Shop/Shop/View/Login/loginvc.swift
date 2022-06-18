//
//  loginvc.swift
//  Shop
//
//  Created by Salma on 29/05/2022.
//

import UIKit
import TextFieldEffects
class loginvc: UIViewController {
    var delegate=UIApplication.shared.delegate as! AppDelegate
    var loginviewModel:loginTemp?
    var email,password:String!
    var homeFlag = true
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var loginImg: UIImageView!
    
    @IBOutlet weak var emailTf: HoshiTextField!
    
    @IBOutlet weak var passTf: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      loginviewModel=LoginViewModel(appdelegate: &delegate)
      //  signInBtn.backgroundColor =  .green
        signInBtn.layer.cornerRadius=20
        loginImg.image=UIImage(named: "shop")
        bindToViewModel()
        // Do any additional setup after loading the view.
    }

    func bindToViewModel(){
        loginviewModel?.bindNavigate={
            [weak self] in
            self?.navigate()
        }
        loginviewModel?.bindDontNavigate={
            [weak self] in
           let message = self?.loginviewModel?.alertMessage ?? "can not login please check your info"
            self?.showAlert(message: message)
        }
    }
    func navigate(){
        if homeFlag{
            let home = MyTabBar(nibName: "MyTabBar", bundle: nil)
            self.navigationController?.pushViewController(home, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func signInBtn(_ sender: Any) {
        email=emailTf.text
        password=passTf.text
        loginviewModel?.login(email: email, password: password)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        self.navigationController?.pushViewController(registerVc(), animated: true)
    }
    
    func showAlert(message:String){
        let alert=UIAlertController(title: "warning", message: message, preferredStyle: .alert)
        let okAction=UIAlertAction(title: "OK", style: .default){
            (action) in
            print("alert")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
