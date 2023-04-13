//
//  UIBarButtonItem-Extension.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/13.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    //苹果建议使用构造函数的形式
    
    /*
    便利构造函数：
     1.convenience开头
     2.在构造函数中必须明确调用一个设计的构造函数(self)
     */
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSizeZero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSizeZero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        self.init(customView: btn)
    }
    
    /*
     //类方法
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPointZero, size: size)
        let item = UIBarButtonItem(customView: btn)
        return item
    }
     */
}
