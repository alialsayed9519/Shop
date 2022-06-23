//
//  OrderCell.swift
//  Shop
//
//  Created by yasmeen hosny on 6/21/22.
//

import UIKit

class OrderCell: UITableViewCell {
    
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        print("aya haga")
    }
    
    func updateUI(order: OrderFromAPI){
        let address = order.customer!.default_address!
        let addressText = "\(address.country), \(address.city), \(address.address1)"
        self.addressLabel.text = addressText
        self.dataLabel.text = order.created_at!
        self.paymentMethodLabel.text = order.gateway!
        self.totalLabel.text = "\(order.current_total_price!) \(order.currency!)"
        self.discountLabel.text = "\(order.total_discounts!) \(order.currency!)"
        self.statusLabel.text = order.financial_status!
    }
}
