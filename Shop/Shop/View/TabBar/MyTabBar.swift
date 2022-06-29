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
       // C2DED1
      //  self.tabBar.backgroundColor = UIColor(sd_hexString: "C2DED1")
        guard let items = self.tabBar.items else {return}
    //    let image = UIImage(systemName: "house")
//        354259
//        image?.withTintColor(Color(r: 35, g: 42, b: 59, a: Double))
        let images = ["house","star.fill" ,"person"]
        
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
