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
        // Do any additional setup after loading the view.

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarStory") as! TabBarController
                let nav = UINavigationController(rootViewController: vc)
                UIApplication.shared.windows.first?.rootViewController = nav
      
        
       
    }


}

