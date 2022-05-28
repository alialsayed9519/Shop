//
//  MyTabBar.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit

class MyTabBar: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let home = HomeVc()
        let catagory = CategoryVc()
        let profile = ProfileVc()
        
        self.setViewControllers([home, catagory, profile], animated: true)
        self.tabBar.backgroundColor = .white
        
        guard let items = self.tabBar.items else {return}
        let images = ["house","star.fill" ,"person"]
        
        for i in 0...2 {
            if #available(iOS 13.0, *) {
                items[i].image = UIImage(systemName: images[i])
            } else {
                // Fallback on earlier versions
            }
        }
        
    }

}
