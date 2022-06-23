//
//  launchScreenVc.swift
//  Shop
//
//  Created by Salma on 01/01/1980.
//

import UIKit
import Lottie
class launchScreenVc: UIViewController {
    private var  animationView :AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("salma")
        print("anima")
        animationView = .init(name: "coffee")
          
          animationView!.frame = view.bounds
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
          animationView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
          animationView!.animationSpeed = 0.5
          
          view.addSubview(animationView!)
          
          // 6. Play animation
          
          animationView!.play()
        print("ffffff")
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                    guard let self = self else {return}
                        self.navigationController?.pushViewController(EntryVc(), animated: true)
                    
                }
    }
        // Do any additional setup after loading the view.
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
