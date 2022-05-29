//
//  loginvc.swift
//  Shop
//
//  Created by Salma on 29/05/2022.
//

import UIKit

class loginvc: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var passtf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var loginimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        skipBtn.backgroundColor =  .blue
        skipBtn.layer.cornerRadius=20
        signInBtn.backgroundColor =  .blue
        signInBtn.layer.cornerRadius=20

        // Do any additional setup after loading the view.
    }


    @IBAction func signInBtn(_ sender: Any) {
    }
    
    @IBAction func skipBtn(_ sender: Any) {
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
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
