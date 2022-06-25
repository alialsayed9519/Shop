//
//  doneVc.swift
//  Shop
//
//  Created by Salma on 22/06/2022.
//

import UIKit
import Lottie
class doneVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setDoneAnimation()
    }
    func setDoneAnimation(){
        let animationView = AnimationView()
                
                animationView.animation = Animation.named("donn")
                //animationView.contentMode = .scaleAspectFit
                animationView.frame = view.bounds
                animationView.loopMode = .loop
                animationView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                animationView.center = view.center
               
                animationView.play()
                view.addSubview(animationView)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                    guard let self = self else {return}
                        self.navigationController?.pushViewController(HomeVc(), animated: true)
                    
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
