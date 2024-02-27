//
//  ViewController.swift
//  ScoreLine
//
//  Created by Om Gandhi on 16/02/24.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {

    @IBOutlet weak var imgLogo: SDAnimatedImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
        let animatedLogo = SDAnimatedImage(named: "Scoreline.gif")
        imgLogo.image = animatedLogo
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            let defaults = UserDefaults.standard
            if defaults.bool(forKey: "firstTime") == false{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartupStory") as! StartupController
                UIApplication.shared.windows.first?.rootViewController = vc
            }
            else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarStory") as! TabBarController
                let nav = UINavigationController(rootViewController: vc)
                UIApplication.shared.windows.first?.rootViewController = nav
            }
        }
        
       
    }


}

