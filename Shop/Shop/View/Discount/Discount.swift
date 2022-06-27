//
//  Discount.swift
//  Shop
//
//  Created by yasmeen hosny on 6/27/22.
//

import UIKit

class Discount: UIViewController {

    @IBOutlet weak var fiftyDiscountLabel: UILabel!
    @IBOutlet weak var thirtyDiscountLabel: UILabel!
    
    private let defaults = userDefault()
    private let viewModel = ShopingViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.bindPriceRules = self.bindPriceRules
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if noCopuns(){
            viewModel.fetchPriceRules()
        }
        else{
            showCopuns()
        }
    }
    
    private func noCopuns() -> Bool{
        return defaults.getFiftyDescountTitle() == "" && defaults.getThirtyDescountTitle() == ""
    }
    
    private func showCopuns(){
        if defaults.getThirtyDescountTitle() == ""{
            thirtyDiscountLabel.textColor = .red
            thirtyDiscountLabel.text = "Used"
        }
        else {
            thirtyDiscountLabel.text = defaults.getThirtyDescountTitle()
        }
        if defaults.getFiftyDescountTitle() == ""{
            fiftyDiscountLabel.textColor = .red
            fiftyDiscountLabel.text = "Used"
        }
        else {
            fiftyDiscountLabel.text = defaults.getFiftyDescountTitle()
        }
    }
    
    private func bindPriceRules(){
        fiftyDiscountLabel.text = defaults.getFiftyDescountTitle()
        thirtyDiscountLabel.text = defaults.getThirtyDescountTitle()
    }

    @IBAction func countinue(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyFifty(_ sender: Any) {
        UIPasteboard.general.string = fiftyDiscountLabel.text
    }
    
    @IBAction func copyThirty(_ sender: Any) {
        UIPasteboard.general.string = thirtyDiscountLabel.text
    }
}
