//
//  currAlert.swift
//  Shop
//
//  Created by Salma on 29/06/2022.
//

import UIKit

class currAlert: UIViewController {

    @IBOutlet weak var egpButt: UIButton!
    @IBOutlet weak var egpButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        egpButt.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
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
