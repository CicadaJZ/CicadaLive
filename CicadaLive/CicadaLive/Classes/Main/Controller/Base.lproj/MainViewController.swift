//
//  MainViewController.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/13.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let childArr = ["Home", "Live", "Follow", "Profile"]
        for item in childArr {
            addChildVC(name: item)
        }
    }
    
    func addChildVC(name:String) {
        //通过storyboard获取控制器
        let child = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        addChild(child)
    }

}
