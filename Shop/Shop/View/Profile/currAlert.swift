//
//  currAlert.swift
//  Shop
//
//  Created by Salma on 29/06/2022.
//

import UIKit

class currAlert: UIViewController {

    @IBOutlet var viewww: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var usdButt: UIButton!
    @IBOutlet weak var egpButt: UIButton!
    @IBOutlet weak var egpButton: NSLayoutConstraint!
    var currencyViewMode = currencyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        egpButt.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setUoView()
        animationView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setUoView(){
        alertView.layer.cornerRadius = 25
        
    }
    func animationView(){
        alertView.alpha=0
        self.alertView.frame.origin.y=self.alertView.frame.origin.y + 0
        UIView.animate(withDuration: 0.0, animations: {
            ()->Void
            in
            self.alertView.alpha=1.0;
            self.alertView.frame.origin.y=self.alertView.frame.origin.y - 0
        })
    }
    @IBAction func egpButton(_ sender: Any) {
        currencyViewMode.setCurrency(key: "currency", value: "EGP")
        egpButt.setImage(UIImage(named: "radioOn"), for: .normal)
        usdButt.setImage(UIImage(named: "radioOf"), for: .normal)
    }
    
    @IBAction func usdButton(_ sender: Any) {
        currencyViewMode.setCurrency(key: "currency", value: "USD")
        usdButt.setImage(UIImage(named: "radioOn"), for: .normal)
        egpButt.setImage(UIImage(named: "radioOf"), for: .normal)
    }
}
