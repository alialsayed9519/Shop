//
//  luanchVc.swift
//  Shop
//
//  Created by Salma on 25/06/2022.
//

import UIKit
import Lottie
class luanchVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
print("salma")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setLaunchAnimation()
    }

    func setLaunchAnimation(){
        let animationView = AnimationView()
        
        animationView.animation = Animation.named("online")
        //animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        animationView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        animationView.center = view.center
       
        animationView.play()
        view.addSubview(animationView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.navigationController?.pushViewController(OnBoardVc(), animated: true)
        }

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
