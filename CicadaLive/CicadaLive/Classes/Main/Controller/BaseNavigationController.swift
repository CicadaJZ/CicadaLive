//
//  BaseNavigationController.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/15.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //实现全屏pop
        
        //获取系统手势
        let systemGes = interactivePopGestureRecognizer
        //获取手势添加到的view
        let gesView = systemGes?.view
        
        //获取target/action
        
        //利用运行时机制查看UIGestureRecognizer所有的属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        
        //targets:取出的targets是一个数组
        guard let targets = systemGes?.value(forKey: "_targets") as? [NSObject] else { return }
        print("target--:\(targets)")
        
        //targetObjc是一个字典
        guard let targetObjc = targets.first else { return }
        
        //取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        //取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //创建自己的pan手势
        let customGes = UIPanGestureRecognizer(target: target, action: action)
        gesView?.addGestureRecognizer(customGes)
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

}
