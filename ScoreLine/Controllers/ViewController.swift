//
//  ViewController.swift
//  ScoreLine
//
//  Created by Om Gandhi on 16/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

