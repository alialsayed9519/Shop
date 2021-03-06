//
//  MyTabBar.swift
//  Shop
//
//  Created by Ali on 25/05/2022.
//

import UIKit
import Lottie

class MyTabBar: UITabBarController {
    let defaults:userDefaultsprotocol=userDefault()
    let home = HomeVc()
    let catagory = CategoryVc()
    let profile = ProfileVc()
    let guestProfile=GuestProfileVc()

    override func viewDidLoad() {
        super.viewDidLoad()
               // self.setViewControllers([home, catagory, profile], animated: true)
        let isLogged = defaults.isLoggedIn()
        setViews(isLogedIn: isLogged)
        self.tabBar.backgroundColor = .white
        guard let items = self.tabBar.items else {return}
        let images = ["house","square.grid.3x2.fill" ,"person"]
        
        for i in 0...2 {
            if #available(iOS 13.0, *) {
                items[i].image = UIImage(systemName: images[i])
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    func setViews(isLogedIn:Bool){
        if isLogedIn{
            self.setViewControllers([home, catagory, profile], animated: true)
        }
        else{
            self.setViewControllers([home, catagory, guestProfile], animated: true)
        }
    }

}
